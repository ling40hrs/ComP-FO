-- --------------------------------------------------------
-- 1. DATABASE CREATION (Start Fresh)
-- --------------------------------------------------------
DROP DATABASE IF EXISTS kkopi_tea_db;
CREATE DATABASE kkopi_tea_db;
USE kkopi_tea_db;

-- --------------------------------------------------------
-- 2. PARENT TABLES (Must be created first)
-- --------------------------------------------------------

-- Table: Categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL,
    description VARCHAR(100)
);

-- Table: Suppliers
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    contact_number VARCHAR(20),
    address TEXT
);

-- Table: Employees
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('Manager', 'Barista', 'Owner') NOT NULL, 
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    date_hired DATE
);

-- --------------------------------------------------------
-- 3. CHILD TABLES (Link to parents via Foreign Keys)
-- --------------------------------------------------------

-- Table: Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(100) NOT NULL,
    size ENUM('Solo', 'Jumbo') DEFAULT 'Solo', 
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- Table: Inventory
CREATE TABLE Inventory (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    item_name VARCHAR(100) NOT NULL,
    quantity_on_hand DECIMAL(10, 2) DEFAULT 0.00,
    unit_measurement VARCHAR(20) NOT NULL, 
    reorder_point INT DEFAULT 10, 
    expiration_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE SET NULL
);

-- Table: Product_Recipes (Junction Table)
CREATE TABLE Product_Recipes (
    recipe_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity_required DECIMAL(10, 4) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id) ON DELETE CASCADE
);

-- Table: Orders
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Cash', 'Online Payment') NOT NULL, 
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE SET NULL
);

-- Table: Order_Details
CREATE TABLE Order_Details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);