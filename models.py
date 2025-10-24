from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


class Supplier(Base):
    __tablename__ = "supplier"
    id_supplier = Column(Integer, primary_key=True, index=True, autoincrement=True)
    Name_sup = Column(String(45), nullable=False)
    adress_sup = Column(String(80))
    number_sup = Column(String(12))


class Product(Base):
    __tablename__ = "Product"
    id_Product = Column(Integer, primary_key=True, index=True, autoincrement=True)
    Name_tov = Column(String(45), nullable=False)
    price = Column(Float)
    id_supplier = Column(Integer, ForeignKey("supplier.id_supplier"))
    quantity = Column(Integer, default=0)

    supplier = relationship("Supplier")

class Buyer(Base):
    __tablename__ = "Buyers"
    id_buyers = Column(Integer, primary_key=True, index=True)
    Buyer_name = Column(String(45), nullable=False)
    number_buy = Column(String(12))
    adress_buy = Column(String(45))


class Employee(Base):
    __tablename__ = "employees"
    id_employees = Column(Integer, primary_key=True, index=True, autoincrement=True)
    FIO = Column(String(45), nullable=False)
    expirience = Column(String(45))
    number_emp = Column(String(12))


class Order(Base):
    __tablename__ = "order"
    id_order = Column(Integer, primary_key=True, index=True, autoincrement=True)
    Code = Column(String(45))
    id_employees = Column(Integer, ForeignKey("employees.id_employees"))
    id_buyers = Column(Integer, ForeignKey("Buyers.id_buyers"))
    status = Column(String(50), default="В обработке")
    description = Column(String(500))

    employee = relationship("Employee")
    buyer = relationship("Buyer")
    items = relationship("OrderItem", back_populates="order")

class OrderItem(Base):
    __tablename__ = "order_items"
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    id_order = Column(Integer, ForeignKey("order.id_order"))
    id_Product = Column(Integer, ForeignKey("Product.id_Product"))
    quantity = Column(Integer, default=1)

    product = relationship("Product")
    order = relationship("Order")