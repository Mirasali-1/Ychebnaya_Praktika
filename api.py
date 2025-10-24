from fastapi import FastAPI, Depends, Request, Form, HTTPException
from fastapi.responses import HTMLResponse, RedirectResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session
from database import SessionLocal, engine
from sqlalchemy.orm import joinedload
import models
from generator.docx_generator import generate_order_docx, prepare_order_data
from generator.excel_generator import generate_orders_excel, prepare_all_orders_data
from generator.pdf_catalog_generator import generate_products_catalog, prepare_products_data, generate_orders_pdf
import random
import string
from datetime import datetime


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@app.get("/", response_class=HTMLResponse)
def home(request: Request, db: Session = Depends(get_db)):
    warehouse_count = db.query(models.Product).count()
    supplier_count = db.query(models.Supplier).count()
    order_count = db.query(models.Order).count()
    employee_count = db.query(models.Employee).count()
    buyer_count = db.query(models.Buyer).count()

    return templates.TemplateResponse("index.html", {
        "request": request,
        "warehouse_count": warehouse_count,
        "supplier_count": supplier_count,
        "order_count": order_count,
        "employee_count": employee_count,
        "buyer_count": buyer_count
    })


# ========== WAREHOUSE (PRODUCTS) ==========
@app.get("/warehouse", response_class=HTMLResponse)
def warehouse_page(request: Request, db: Session = Depends(get_db)):
    products = db.query(models.Product).all()
    # Получаем уникальных поставщиков для фильтра
    unique_suppliers = db.query(models.Supplier.Name_sup).distinct().all()
    unique_suppliers = [supplier[0] for supplier in unique_suppliers if supplier[0]]

    return templates.TemplateResponse("warehouse.html", {
        "request": request,
        "products": products,
        "unique_suppliers": sorted(unique_suppliers)
    })


@app.get("/warehouse/add", response_class=HTMLResponse)
def add_warehouse_page(request: Request, db: Session = Depends(get_db)):
    suppliers = db.query(models.Supplier).all()
    return templates.TemplateResponse("warehouse_add.html", {
        "request": request,
        "suppliers": suppliers
    })


@app.post("/warehouse/add")
async def add_product(
        request: Request,
        db: Session = Depends(get_db)
):
    try:
        form_data = await request.form()

        name = form_data.get("name")
        price = float(form_data.get("price"))
        supplier_id = int(form_data.get("supplier_id"))
        quantity = int(form_data.get("quantity", 0))

        product = models.Product(
            Name_tov=name,
            price=price,
            id_supplier=supplier_id,
            quantity=quantity
        )
        db.add(product)
        db.commit()
        return RedirectResponse(url="/warehouse", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.get("/product/{product_id}/change", response_class=HTMLResponse)
def change_product_page(request: Request, product_id: int, db: Session = Depends(get_db)):
    product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
    suppliers = db.query(models.Supplier).all()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    return templates.TemplateResponse("product_change.html", {
        "request": request,
        "product": product,
        "suppliers": suppliers
    })


@app.post("/product/{product_id}/change")
async def change_product(
        product_id: int,
        request: Request,
        db: Session = Depends(get_db)
):
    try:
        form_data = await request.form()

        name = form_data.get("name")
        price = float(form_data.get("price"))
        quantity = int(form_data.get("quantity", 0))
        supplier_id = int(form_data.get("supplier_id"))

        product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
        if product:
            product.Name_tov = name
            product.price = price
            product.quantity = quantity
            product.id_supplier = supplier_id
            db.commit()

        return RedirectResponse(url="/warehouse", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== SUPPLIERS ==========
@app.get("/supplier", response_class=HTMLResponse)
def suppliers_page(request: Request, db: Session = Depends(get_db)):
    suppliers = db.query(models.Supplier).all()

    # Получаем уникальные города из адресов для фильтра
    unique_cities = set()
    for supplier in suppliers:
        if supplier.adress_sup:
            # Берем первую часть адреса (обычно город)
            city = supplier.adress_sup.split(',')[0].strip()
            if city:
                unique_cities.add(city)

    return templates.TemplateResponse("supplier.html", {
        "request": request,
        "suppliers": suppliers,
        "unique_cities": sorted(unique_cities)
    })


@app.get("/supplier/add", response_class=HTMLResponse)
def add_supplier_page(request: Request):
    return templates.TemplateResponse("supplier_add.html", {"request": request})


@app.post("/supplier/add")
def add_supplier(
        name: str = Form(...),
        address: str = Form(...),
        number: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        supplier = models.Supplier(Name_sup=name, adress_sup=address, number_sup=number)
        db.add(supplier)
        db.commit()
        return RedirectResponse(url="/supplier", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.get("/supplier/{supplier_id}/change", response_class=HTMLResponse)
def change_supplier_page(request: Request, supplier_id: int, db: Session = Depends(get_db)):
    supplier = db.query(models.Supplier).filter(models.Supplier.id_supplier == supplier_id).first()
    if not supplier:
        raise HTTPException(status_code=404, detail="Supplier not found")
    return templates.TemplateResponse("supplier_change.html", {
        "request": request,
        "supplier": supplier
    })


@app.post("/supplier/{supplier_id}/change")
def change_supplier(
        supplier_id: int,
        name: str = Form(...),
        address: str = Form(...),
        number: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        supplier = db.query(models.Supplier).filter(models.Supplier.id_supplier == supplier_id).first()
        if supplier:
            supplier.Name_sup = name
            supplier.adress_sup = address
            supplier.number_sup = number
            db.commit()
        return RedirectResponse(url="/supplier", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== ORDERS ==========
@app.get("/orders", response_class=HTMLResponse)
def orders_page(request: Request, db: Session = Depends(get_db)):
    orders = db.query(models.Order).options(
        joinedload(models.Order.employee),
        joinedload(models.Order.buyer),
        joinedload(models.Order.items).joinedload(models.OrderItem.product)
    ).all()

    # Получаем уникальных покупателей и сотрудников для фильтров
    unique_buyers = db.query(models.Buyer.Buyer_name).distinct().all()
    unique_buyers = [buyer[0] for buyer in unique_buyers if buyer[0]]

    unique_employees = db.query(models.Employee.FIO).distinct().all()
    unique_employees = [employee[0] for employee in unique_employees if employee[0]]

    return templates.TemplateResponse("orders.html", {
        "request": request,
        "orders": orders,
        "unique_buyers": sorted(unique_buyers),
        "unique_employees": sorted(unique_employees)
    })

@app.get("/orders/add", response_class=HTMLResponse)
def add_order_page(request: Request, db: Session = Depends(get_db)):
    employees = db.query(models.Employee).all()
    products = db.query(models.Product).all()
    buyers = db.query(models.Buyer).all()

    # Генерируем случайный код для формы
    random_code = generate_order_code()

    return templates.TemplateResponse("order_add.html", {
        "request": request,
        "employees": employees,
        "products": products,
        "buyers": buyers,
        "random_code": random_code
    })

def generate_order_code():
    """Генерирует случайный код заказа"""
    timestamp = datetime.now().strftime('%H%M%S')
    random_chars = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
    return f"ORD{timestamp}{random_chars}"


@app.post("/orders/add")
async def add_order(
        request: Request,
        db: Session = Depends(get_db)
):
    try:
        form_data = await request.form()

        # Извлекаем данные из формы
        code = form_data.get("code")
        employee_id = form_data.get("employee_id")
        buyer_id = form_data.get("buyer_id")

        if not all([code, employee_id, buyer_id]):
            raise HTTPException(status_code=400, detail="Заполните все обязательные поля")

        # Получаем массивы товаров и количеств
        product_ids = form_data.getlist("product_id")
        quantities = form_data.getlist("quantity")

        if not product_ids or not quantities or not product_ids[0] or not quantities[0]:
            raise HTTPException(status_code=400, detail="Необходимо добавить хотя бы один товар")

        # Проверка наличия товаров
        for i in range(len(product_ids)):
            if product_ids[i] and quantities[i]:
                product_id = int(product_ids[i])
                order_quantity = int(quantities[i])

                product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
                if not product:
                    raise HTTPException(status_code=400, detail=f"Товар с ID {product_id} не найден")

                if product.quantity < order_quantity:
                    raise HTTPException(
                        status_code=400,
                        detail=f"Недостаточно товара '{product.Name_tov}'. Доступно: {product.quantity}, заказано: {order_quantity}"
                    )

        # Если все проверки пройдены, создаем заказ
        order = models.Order(
            Code=code,
            id_employees=int(employee_id),
            id_buyers=int(buyer_id)
        )
        db.add(order)
        db.flush()  # Получаем ID заказа

        # Добавляем товары в заказ и вычитаем из наличия
        for i in range(len(product_ids)):
            if product_ids[i] and quantities[i]:
                product_id = int(product_ids[i])
                order_quantity = int(quantities[i])

                product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
                product.quantity -= order_quantity

                order_item = models.OrderItem(
                    order_id=order.id_order,
                    product_id=product_id,
                    quantity=order_quantity
                )
                db.add(order_item)

        db.commit()
        return RedirectResponse(url="/orders", status_code=303)
    except Exception as e:
        db.rollback()
        print(f"Error: {str(e)}")
        raise HTTPException(status_code=400, detail=str(e))


@app.get("/order/{order_id}/change", response_class=HTMLResponse)
def change_order_page(request: Request, order_id: int, db: Session = Depends(get_db)):
    order = db.query(models.Order).options(
        joinedload(models.Order.items)
    ).filter(models.Order.id_order == order_id).first()

    employees = db.query(models.Employee).all()
    products = db.query(models.Product).all()
    buyers = db.query(models.Buyer).all()

    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    return templates.TemplateResponse("order_change.html", {
        "request": request,
        "order": order,
        "employees": employees,
        "products": products,
        "buyers": buyers
    })


@app.post("/order/{order_id}/change")
async def change_order(
        order_id: int,
        request: Request,
        db: Session = Depends(get_db)
):
    try:
        form_data = await request.form()

        # Извлекаем данные из формы
        code = form_data.get("code")
        employee_id = form_data.get("employee_id")
        buyer_id = form_data.get("buyer_id")

        if not all([code, employee_id, buyer_id]):
            raise HTTPException(status_code=400, detail="Заполните все обязательные поля")

        # Получаем массивы товаров и количеств
        product_ids = form_data.getlist("product_id")
        quantities = form_data.getlist("quantity")

        if not product_ids or not quantities or not product_ids[0] or not quantities[0]:
            raise HTTPException(status_code=400, detail="Необходимо добавить хотя бы один товар")

        order = db.query(models.Order).options(
            joinedload(models.Order.items).joinedload(models.OrderItem.product)
        ).filter(models.Order.id_order == order_id).first()

        if order:
            # ВОЗВРАЩАЕМ СТАРЫЕ ТОВАРЫ НА СКЛАД
            for old_item in order.items:
                if old_item.product:
                    old_item.product.quantity += old_item.quantity

            # ПРОВЕРЯЕМ НАЛИЧИЕ НОВЫХ ТОВАРОВ
            for i in range(len(product_ids)):
                if product_ids[i] and quantities[i]:
                    product_id = int(product_ids[i])
                    order_quantity = int(quantities[i])

                    product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
                    if not product:
                        raise HTTPException(status_code=400, detail=f"Товар с ID {product_id} не найден")

                    if product.quantity < order_quantity:
                        raise HTTPException(
                            status_code=400,
                            detail=f"Недостаточно товара '{product.Name_tov}'. Доступно: {product.quantity}, заказано: {order_quantity}"
                        )

            order.Code = code
            order.id_employees = int(employee_id)
            order.id_buyers = int(buyer_id)

            # Удаляем старые товары
            db.query(models.OrderItem).filter(models.OrderItem.order_id == order_id).delete()

            # Добавляем новые товары и ВЫЧИТАЕМ ИЗ НАЛИЧИЯ
            for i in range(len(product_ids)):
                if product_ids[i] and quantities[i]:
                    product_id = int(product_ids[i])
                    order_quantity = int(quantities[i])

                    # Вычитаем из наличия
                    product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
                    product.quantity -= order_quantity

                    order_item = models.OrderItem(
                        order_id=order.id_order,
                        product_id=product_id,
                        quantity=order_quantity
                    )
                    db.add(order_item)

            db.commit()
        return RedirectResponse(url="/orders", status_code=303)
    except Exception as e:
        db.rollback()
        print(f"Error: {str(e)}")
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/order/{order_id}/intel", response_class=HTMLResponse)
def order_intel_page(request: Request, order_id: int, db: Session = Depends(get_db)):
    order = db.query(models.Order).options(
        joinedload(models.Order.employee),
        joinedload(models.Order.buyer),
        joinedload(models.Order.items).joinedload(models.OrderItem.product)
    ).filter(models.Order.id_order == order_id).first()

    if not order:
        raise HTTPException(status_code=404, detail="Order not found")

    return templates.TemplateResponse("order_intel.html", {
        "request": request,
        "order": order
    })


@app.post("/order/{order_id}/intel")
def update_order_intel(
        order_id: int,
        status: str = Form(...),
        description: str = Form(None),
        db: Session = Depends(get_db)
):
    try:
        order = db.query(models.Order).filter(models.Order.id_order == order_id).first()
        if order:
            order.status = status
            order.description = description
            db.commit()

        return RedirectResponse(url=f"/order/{order_id}/intel", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== EMPLOYEES ==========
@app.get("/employees", response_class=HTMLResponse)
def employees_page(request: Request, db: Session = Depends(get_db)):
    employees = db.query(models.Employee).all()

    return templates.TemplateResponse("employees.html", {
        "request": request,
        "employees": employees
    })


@app.get("/employees/add", response_class=HTMLResponse)
def add_employee_page(request: Request):
    return templates.TemplateResponse("employee_add.html", {"request": request})


@app.post("/employees/add")
def add_employee(
        fio: str = Form(...),
        experience: str = Form(...),
        number: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        employee = models.Employee(FIO=fio, expirience=experience, number_emp=number)
        db.add(employee)
        db.commit()
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.get("/employee/{employee_id}/change", response_class=HTMLResponse)
def change_employee_page(request: Request, employee_id: int, db: Session = Depends(get_db)):
    employee = db.query(models.Employee).filter(models.Employee.id_employees == employee_id).first()
    if not employee:
        raise HTTPException(status_code=404, detail="Employee not found")
    return templates.TemplateResponse("employee_change.html", {
        "request": request,
        "employee": employee
    })


@app.post("/employee/{employee_id}/change")
def change_employee(
        employee_id: int,
        fio: str = Form(...),
        experience: str = Form(...),
        number: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        employee = db.query(models.Employee).filter(models.Employee.id_employees == employee_id).first()
        if employee:
            employee.FIO = fio
            employee.expirience = experience
            employee.number_emp = number
            db.commit()
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== BUYERS ==========
@app.get("/buyers", response_class=HTMLResponse)
def buyers_page(request: Request, db: Session = Depends(get_db)):
    buyers = db.query(models.Buyer).all()

    # Получаем уникальные города из адресов для фильтра
    unique_cities = set()
    for buyer in buyers:
        if buyer.adress_buy:
            # Берем первую часть адреса (обычно город)
            city = buyer.adress_buy.split(',')[0].strip()
            if city:
                unique_cities.add(city)

    return templates.TemplateResponse("buyers.html", {
        "request": request,
        "buyers": buyers,
        "unique_cities": sorted(unique_cities)
    })

@app.get("/buyers/add", response_class=HTMLResponse)
def add_buyer_page(request: Request):
    return templates.TemplateResponse("buyer_add.html", {"request": request})


@app.post("/buyers/add")
def add_buyer(
        name: str = Form(...),
        number: str = Form(...),
        address: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        buyer = models.Buyer(Buyer_name=name, number_buy=number, adress_buy=address)
        db.add(buyer)
        db.commit()
        return RedirectResponse(url="/buyers", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.get("/buyer/{buyer_id}/change", response_class=HTMLResponse)
def change_buyer_page(request: Request, buyer_id: int, db: Session = Depends(get_db)):
    buyer = db.query(models.Buyer).filter(models.Buyer.id_buyers == buyer_id).first()
    if not buyer:
        raise HTTPException(status_code=404, detail="Buyer not found")
    return templates.TemplateResponse("buyer_change.html", {
        "request": request,
        "buyer": buyer
    })


@app.post("/buyer/{buyer_id}/change")
def change_buyer(
        buyer_id: int,
        name: str = Form(...),
        number: str = Form(...),
        address: str = Form(...),
        db: Session = Depends(get_db)
):
    try:
        buyer = db.query(models.Buyer).filter(models.Buyer.id_buyers == buyer_id).first()
        if buyer:
            buyer.Buyer_name = name
            buyer.number_buy = number
            buyer.adress_buy = address
            db.commit()
        return RedirectResponse(url="/buyers", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== DELETE ENDPOINTS ==========

@app.post("/product/{product_id}/delete")
def delete_product(product_id: int, db: Session = Depends(get_db)):
    try:
        product = db.query(models.Product).filter(models.Product.id_Product == product_id).first()
        if product:
            # Проверяем, нет ли заказов с этим товаром
            order_items_count = db.query(models.OrderItem).filter(models.OrderItem.product_id == product_id).count()
            if order_items_count > 0:
                raise HTTPException(status_code=400, detail="Нельзя удалить товар, который есть в заказах")

            db.delete(product)
            db.commit()
        return RedirectResponse(url="/warehouse", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.post("/supplier/{supplier_id}/delete")
def delete_supplier(supplier_id: int, db: Session = Depends(get_db)):
    try:
        supplier = db.query(models.Supplier).filter(models.Supplier.id_supplier == supplier_id).first()
        if supplier:
            # Проверяем, нет ли товаров у этого поставщика
            products_count = db.query(models.Product).filter(models.Product.id_supplier == supplier_id).count()
            if products_count > 0:
                raise HTTPException(status_code=400, detail="Нельзя удалить поставщика, у которого есть товары")
            db.delete(supplier)
            db.commit()
        return RedirectResponse(url="/supplier", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.post("/employee/{employee_id}/delete")
def delete_employee(employee_id: int, db: Session = Depends(get_db)):
    try:
        employee = db.query(models.Employee).filter(models.Employee.id_employees == employee_id).first()
        if employee:
            # Проверяем, нет ли заказов у этого сотрудника
            orders_count = db.query(models.Order).filter(models.Order.id_employees == employee_id).count()
            if orders_count > 0:
                raise HTTPException(status_code=400, detail="Нельзя удалить сотрудника, у которого есть заказы")
            db.delete(employee)
            db.commit()
        return RedirectResponse(url="/employees", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.post("/buyer/{buyer_id}/delete")
def delete_buyer(buyer_id: int, db: Session = Depends(get_db)):
    try:
        buyer = db.query(models.Buyer).filter(models.Buyer.id_buyers == buyer_id).first()
        if buyer:
            # Проверяем, нет ли заказов у этого покупателя
            orders_count = db.query(models.Order).filter(models.Order.id_buyers == buyer_id).count()
            if orders_count > 0:
                raise HTTPException(status_code=400, detail="Нельзя удалить покупателя, у которого есть заказы")
            db.delete(buyer)
            db.commit()
        return RedirectResponse(url="/buyers", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


@app.post("/order/{order_id}/delete")
def delete_order(order_id: int, db: Session = Depends(get_db)):
    try:
        order = db.query(models.Order).options(
            joinedload(models.Order.items).joinedload(models.OrderItem.product)
        ).filter(models.Order.id_order == order_id).first()

        if order:
            # ВОЗВРАЩАЕМ ТОВАРЫ НА СКЛАД
            for item in order.items:
                if item.product:
                    item.product.quantity += item.quantity

            # Удаляем связанные товары
            db.query(models.OrderItem).filter(models.OrderItem.order_id == order_id).delete()
            # Затем удаляем заказ
            db.delete(order)
            db.commit()
        return RedirectResponse(url="/orders", status_code=303)
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=400, detail=str(e))


# ========== GENERATION ==========

@app.get("/order/{order_id}/docx")
def download_order_docx(order_id: int, db: Session = Depends(get_db)):
    try:
        # Получаем заказ с связанными данными
        order = db.query(models.Order).options(
            joinedload(models.Order.items).joinedload(models.OrderItem.product),
            joinedload(models.Order.buyer),
            joinedload(models.Order.employee)
        ).filter(models.Order.id_order == order_id).first()

        if not order:
            raise HTTPException(status_code=404, detail="Order not found")

        # Подготавливаем данные
        order_data = prepare_order_data(order, db)

        # Генерируем DOCX из шаблона
        template_path = "templates/primer.docx"
        output_path = generate_order_docx(order_data, template_path)

        # Возвращаем файл для скачивания
        filename = f"order_{order.Code}.docx"
        return FileResponse(
            path=output_path,
            filename=filename,
            media_type='application/vnd.openxmlformats-officedocument.wordprocessingml.document'
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating document: {str(e)}")


@app.get("/orders/excel")
def download_orders_excel(db: Session = Depends(get_db)):
    try:
        # Получаем все заказы с связанными данными
        orders = db.query(models.Order).options(
            joinedload(models.Order.items).joinedload(models.OrderItem.product),
            joinedload(models.Order.buyer),
            joinedload(models.Order.employee)
        ).all()

        if not orders:
            raise HTTPException(status_code=404, detail="No orders found")

        # Подготавливаем данные для Excel
        orders_data = prepare_all_orders_data(orders, db)

        # Генерируем Excel файл
        output_path = generate_orders_excel(orders_data)

        # Возвращаем файл для скачивания
        filename = f"orders_export_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xlsx"
        return FileResponse(
            path=output_path,
            filename=filename,
            media_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating Excel file: {str(e)}")


@app.get("/warehouse/catalog/pdf")
def download_products_catalog_pdf(db: Session = Depends(get_db)):
    try:
        # Получаем все товары с поставщиками
        products = db.query(models.Product).options(
            joinedload(models.Product.supplier)
        ).all()

        if not products:
            raise HTTPException(status_code=404, detail="No products found")

        # Подготавливаем данные
        products_data = prepare_products_data(products, db)

        # Генерируем PDF
        output_path = generate_products_catalog(products_data)

        # Возвращаем файл для скачивания
        filename = f"products_catalog_{datetime.now().strftime('%Y%m%d')}.pdf"
        return FileResponse(
            path=output_path,
            filename=filename,
            media_type='application/pdf'
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating PDF catalog: {str(e)}")


@app.get("/orders/pdf")
def download_orders_pdf(db: Session = Depends(get_db)):
    try:
        # Получаем все заказы
        orders = db.query(models.Order).options(
            joinedload(models.Order.items),
            joinedload(models.Order.buyer)
        ).all()

        if not orders:
            raise HTTPException(status_code=404, detail="No orders found")

        # Подготавливаем данные заказов
        orders_data = []
        for order in orders:
            total_cost = sum(item.product.price * item.quantity for item in order.items if item.product)
            orders_data.append({
                'code': order.Code,
                'buyer_name': order.buyer.Buyer_name if order.buyer else 'Ne ukazan',
                'items': order.items,
                'total_cost': total_cost,
                'status': order.status if order.status else 'V obrabotke'
            })

        # Генерируем PDF
        output_path = generate_orders_pdf(orders_data)

        # Возвращаем файл для скачивания
        filename = f"orders_report_{datetime.now().strftime('%Y%m%d')}.pdf"
        return FileResponse(
            path=output_path,
            filename=filename,
            media_type='application/pdf'
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Error generating PDF report: {str(e)}")