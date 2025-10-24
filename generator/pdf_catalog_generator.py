from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
from reportlab.lib.units import cm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from datetime import datetime
import tempfile
import os


def register_russian_font():
    # Регистрирует шрифт с поддержкой русского языка
    try:
        font_paths = [
            "C:/Windows/Fonts/arial.ttf",
        ]

        registered_fonts = {
            'regular': 'Helvetica',
            'bold': 'Helvetica-Bold'
        }

        for font_path in font_paths:
            if os.path.exists(font_path):
                try:
                    font_name = os.path.basename(font_path).replace('.ttf', '').replace('-Regular', '')
                    pdfmetrics.registerFont(TTFont(font_name, font_path))
                    pdfmetrics.registerFont(TTFont(font_name + '-Bold', font_path))
                    registered_fonts['regular'] = font_name
                    registered_fonts['bold'] = font_name + '-Bold'
                    print(f"Зарегистрирован шрифт: {font_name}")
                    break
                except Exception as e:
                    print(f"Ошибка регистрации шрифта {font_path}: {e}")
                    continue

        return registered_fonts

    except Exception as e:
        print(f"Не удалось зарегистрировать русский шрифт: {e}")
        return {'regular': 'Helvetica', 'bold': 'Helvetica-Bold'}


def generate_products_catalog(products_data, output_path=None):

    # Генерирует PDF каталог товаров
    try:
        if not output_path:
            with tempfile.NamedTemporaryFile(delete=False, suffix='.pdf') as tmp_file:
                output_path = tmp_file.name

        # Регистрируем шрифты
        fonts = register_russian_font()

        # Создаем PDF
        c = canvas.Canvas(output_path, pagesize=A4)
        width, height = A4

        # Устанавливаем координаты для начала текста
        y_position = height - 2 * cm

        # Заголовок
        c.setFont(fonts['bold'], 16)
        c.drawCentredString(width / 2, y_position, "КАТАЛОГ ТОВАРОВ")
        y_position -= 1 * cm

        c.setFont(fonts['bold'], 14)
        c.drawCentredString(width / 2, y_position, 'ООО "Warehouse"')
        y_position -= 0.7 * cm

        c.setFont(fonts['regular'], 10)
        date_text = f"на {datetime.now().strftime('%d.%m.%Y г.')}"
        c.drawCentredString(width / 2, y_position, date_text)
        y_position -= 1.5 * cm

        # Группируем товары по поставщикам
        suppliers = {}
        for product in products_data:
            supplier_name = product['supplier_name']
            if supplier_name not in suppliers:
                suppliers[supplier_name] = []
            suppliers[supplier_name].append(product)

        # Создаем таблицу для каждого поставщика
        for supplier_name, supplier_products in suppliers.items():
            # Проверяем, нужно ли создать новую страницу
            if y_position < 5 * cm:
                c.showPage()
                y_position = height - 2 * cm

            # Заголовок поставщика (на русском)
            c.setFont(fonts['bold'], 12)
            c.setFillColorRGB(0.2, 0.4, 0.6)  # Синий цвет
            supplier_title = f"Поставщик: {supplier_name}"
            c.drawString(2 * cm, y_position, supplier_title)
            y_position -= 0.8 * cm

            # Заголовки таблицы
            c.setFont(fonts['bold'], 10)
            c.setFillColorRGB(0, 0, 0)  # Черный цвет

            # Рисуем заголовки столбцов
            c.drawString(2 * cm, y_position, "Арт.")
            c.drawString(4 * cm, y_position, "Наименование")
            c.drawString(12 * cm, y_position, "Цена")
            c.drawString(16 * cm, y_position, "Наличие")

            # Линия под заголовками
            y_position -= 0.3 * cm
            c.line(2 * cm, y_position, 18 * cm, y_position)
            y_position -= 0.5 * cm

            # Товары поставщика
            c.setFont(fonts['regular'], 9)
            for product in supplier_products:
                # Проверяем, нужно ли создать новую страницу
                if y_position < 3 * cm:
                    c.showPage()
                    y_position = height - 2 * cm

                    # Повторяем заголовки на новой странице
                    c.setFont(fonts['bold'], 10)
                    c.drawString(2 * cm, y_position, "Арт.")
                    c.drawString(4 * cm, y_position, "Наименование")
                    c.drawString(12 * cm, y_position, "Цена")
                    c.drawString(16 * cm, y_position, "Наличие")
                    y_position -= 0.8 * cm
                    c.line(2 * cm, y_position, 18 * cm, y_position)
                    y_position -= 0.5 * cm
                    c.setFont(fonts['regular'], 9)

                # Данные товара
                c.drawString(2 * cm, y_position, str(product['id']))

                # Название товара (обрезанное если слишком длинное)
                name = product['name']
                if len(name) > 35:
                    name = name[:32] + "..."
                c.drawString(4 * cm, y_position, name)

                c.drawString(12 * cm, y_position, f"{product['price']:,.2f} руб.".replace(',', ' '))
                c.drawString(16 * cm, y_position, f"{product['quantity']} шт.")

                y_position -= 0.5 * cm

            # Отступ между поставщиками
            y_position -= 0.5 * cm

        # Добавляем статистику в конце
        if y_position < 8 * cm:
            c.showPage()
            y_position = height - 2 * cm

        # Статистика (на русском)
        total_products = len(products_data)
        total_quantity = sum(product['quantity'] for product in products_data)
        total_suppliers = len(suppliers)
        avg_price = sum(product['price'] for product in products_data) / total_products if total_products > 0 else 0

        c.setFont(fonts['bold'], 12)
        c.drawString(2 * cm, y_position, "СТАТИСТИКА КАТАЛОГА:")
        y_position -= 0.7 * cm

        c.setFont(fonts['regular'], 10)
        stats = [
            f"• Всего товаров: {total_products} позиций",
            f"• Поставщиков: {total_suppliers} компаний",
            f"• Товаров на складе: {total_quantity} ед.",
            f"• Средняя цена: {avg_price:,.2f} руб.",
            "",
            "Контакты:",
            "Телефон: +7 (495) 123-45-67",
            "Email: order@warehouse.ru"
        ]

        for stat in stats:
            if y_position < 3 * cm:
                c.showPage()
                y_position = height - 2 * cm
                c.setFont(fonts['regular'], 10)

            c.drawString(2 * cm, y_position, stat)
            y_position -= 0.5 * cm

        # Сохраняем PDF
        c.save()
        return output_path

    except Exception as e:
        raise Exception(f"Ошибка при генерации PDF: {str(e)}")


def generate_orders_pdf(orders_data, output_path=None):
    """
    Генерирует PDF отчет по заказам с русскими символами
    """
    try:
        if not output_path:
            with tempfile.NamedTemporaryFile(delete=False, suffix='.pdf') as tmp_file:
                output_path = tmp_file.name

        # Регистрируем шрифты
        fonts = register_russian_font()

        # Создаем PDF
        c = canvas.Canvas(output_path, pagesize=A4)
        width, height = A4

        # Устанавливаем координаты для начала текста
        y_position = height - 2 * cm

        # Заголовок
        c.setFont(fonts['bold'], 16)
        c.drawCentredString(width / 2, y_position, "ОТЧЕТ ПО ЗАКАЗАМ")
        y_position -= 1 * cm

        c.setFont(fonts['bold'], 14)
        c.drawCentredString(width / 2, y_position, 'ООО "Warehouse"')
        y_position -= 0.7 * cm

        c.setFont(fonts['regular'], 10)
        date_text = f"за период: {datetime.now().strftime('%d.%m.%Y г.')}"
        c.drawCentredString(width / 2, y_position, date_text)
        y_position -= 1.5 * cm

        # Заголовки таблицы заказов
        c.setFont(fonts['bold'], 10)
        headers = ["Код заказа", "Покупатель", "Товары", "Общая стоимость", "Статус"]

        c.drawString(1 * cm, y_position, headers[0])
        c.drawString(4 * cm, y_position, headers[1])
        c.drawString(8 * cm, y_position, headers[2])
        c.drawString(13 * cm, y_position, headers[3])
        c.drawString(17 * cm, y_position, headers[4])

        y_position -= 0.3 * cm
        c.line(1 * cm, y_position, 19 * cm, y_position)
        y_position -= 0.5 * cm

        # Данные заказов
        c.setFont(fonts['regular'], 8)
        for order in orders_data:
            if y_position < 3 * cm:
                c.showPage()
                y_position = height - 2 * cm
                c.setFont(fonts['bold'], 10)
                c.drawString(1 * cm, y_position, headers[0])
                c.drawString(4 * cm, y_position, headers[1])
                c.drawString(8 * cm, y_position, headers[2])
                c.drawString(13 * cm, y_position, headers[3])
                c.drawString(17 * cm, y_position, headers[4])
                y_position -= 0.8 * cm
                c.line(1 * cm, y_position, 19 * cm, y_position)
                y_position -= 0.5 * cm
                c.setFont(fonts['regular'], 8)

            # Код заказа
            c.drawString(1 * cm, y_position, order['code'])

            # Покупатель
            buyer = order['buyer_name'][:20]
            c.drawString(4 * cm, y_position, buyer)

            # Товары
            products_text = f"{len(order['items'])} товаров"
            c.drawString(8 * cm, y_position, products_text)

            # Общая стоимость
            total = f"{order['total_cost']:,.2f} руб.".replace(',', ' ')
            c.drawString(13 * cm, y_position, total)

            # Статус
            status = order['status']
            c.drawString(17 * cm, y_position, status)

            y_position -= 0.5 * cm

        # Статистика заказов
        if y_position < 6 * cm:
            c.showPage()
            y_position = height - 2 * cm

        total_orders = len(orders_data)
        total_revenue = sum(order['total_cost'] for order in orders_data)

        c.setFont(fonts['bold'], 12)
        c.drawString(2 * cm, y_position, "ИТОГИ:")
        y_position -= 0.7 * cm

        c.setFont(fonts['regular'], 10)
        stats = [
            f"Всего заказов: {total_orders}",
            f"Общая выручка: {total_revenue:,.2f} руб.",
            f"Средний чек: {total_revenue / total_orders:,.2f} руб." if total_orders > 0 else "Средний чек: 0 руб."
        ]

        for stat in stats:
            if y_position < 3 * cm:
                c.showPage()
                y_position = height - 2 * cm
                c.setFont(fonts['regular'], 10)

            c.drawString(2 * cm, y_position, stat)
            y_position -= 0.5 * cm

        c.save()
        return output_path

    except Exception as e:
        raise Exception(f"Ошибка при генерации PDF отчета: {str(e)}")


def prepare_products_data(products, db_session):
    """
    Подготавливает данные товаров для генерации PDF
    """
    products_data = []

    for product in products:
        product_data = {
            'id': product.id_Product,
            'name': product.Name_tov,
            'price': product.price,
            'quantity': product.quantity,
            'supplier_name': product.supplier.Name_sup if product.supplier else 'Без поставщика'
        }
        products_data.append(product_data)

    # Сортируем по поставщикам и названию товара
    products_data.sort(key=lambda x: (x['supplier_name'], x['name']))

    return products_data