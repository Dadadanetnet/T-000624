CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT UNIQUE NOT NULL,
    Password TEXT NOT NULL,
    Phone TEXT,
    Address TEXT,
    City TEXT,
    Country TEXT,
    RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Создание таблицы категорий товаров
CREATE TABLE Categories (
    CategoryID INTEGER PRIMARY KEY AUTOINCREMENT,
    CategoryName TEXT NOT NULL
);

-- Создание таблицы товаров
CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT NOT NULL,
    CategoryID INTEGER,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INTEGER NOT NULL,
    Description TEXT,
    ImageURL TEXT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Создание таблицы заказов
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status TEXT NOT NULL,
    CustomerID INTEGER NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    DeliveryAddress TEXT NOT NULL,
    PaymentMethod TEXT NOT NULL,
    Comment TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Создание таблицы деталей заказов
CREATE TABLE OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY AUTOINCREMENT,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Пример заполнения таблицы категорий
INSERT INTO Categories (CategoryName) VALUES
('Мужская одежда'),
('Женская одежда'),
('Аксессуары');

-- Пример заполнения таблицы товаров
INSERT INTO Products (ProductName, CategoryID, Price, Stock, Description, ImageURL) VALUES
('Футболка мужская', 1, 500.00, 100, 'Классическая мужская футболка', 'https://example.com/tshirt.jpg'),
('Платье женское', 2, 1500.00, 50, 'Летнее платье', 'https://example.com/dress.jpg'),
('Часы наручные', 3, 2500.00, 30, 'Элегантные часы', 'https://example.com/watch.jpg');

-- Пример заполнения таблицы клиентов
INSERT INTO Customers (FirstName, LastName, Email, Password, Phone, Address, City, Country) VALUES
('Иван', 'Иванов', 'ivanov@example.com', 'password123', '1234567890', 'ул. Ленина, д. 1', 'Москва', 'Россия'),
('Анна', 'Петрова', 'petrova@example.com', 'password456', '0987654321', 'ул. Садовая, д. 2', 'Санкт-Петербург', 'Россия');

-- Пример создания заказа
INSERT INTO Orders (Status, CustomerID, TotalAmount, DeliveryAddress, PaymentMethod, Comment) VALUES
('Новый', 1, 3000.00, 'ул. Ленина, д. 1, Москва, Россия', 'Карта', 'Оставить на крыльце');

-- Пример добавления деталей заказа
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 2, 500.00),  -- 2 футболки мужские
(1, 3, 1, 2500.00); -- 1 часы наручные

-- Вывод всех заказов с деталями
SELECT 
    Orders.OrderID,
    Orders.OrderDate,
    Orders.Status,
    Customers.FirstName || ' ' || Customers.LastName AS CustomerName,
    Orders.TotalAmount,
    Orders.DeliveryAddress,
    Orders.PaymentMethod,
    Orders.Comment,
    Products.ProductName,
    OrderDetails.Quantity,
    OrderDetails.Price
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
JOIN 
    OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID;

