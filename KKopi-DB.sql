-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 27, 2025 at 02:52 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kkopi_tea_db`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `best_selling_products`
-- (See below for the actual view)
--
CREATE TABLE `best_selling_products` (
`product_name` varchar(100)
,`Total_Sold` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
(1, 'Milk Tea', 'Classic milk tea series with pearl options'),
(2, 'Fruit Series', 'Refreshing fruit-infused teas'),
(3, 'Frappe', 'Ice blended coffee and non-coffee drinks'),
(4, 'Yakult Series', 'Probiotic yogurt drinks'),
(5, 'Snacks', 'Light bites and pastries');

-- --------------------------------------------------------

--
-- Stand-in structure for view `daily_sales_summary`
-- (See below for the actual view)
--
CREATE TABLE `daily_sales_summary` (
`DATE(transaction_date)` date
,`payment_method` enum('Cash','Online Payment')
,`SUM(total_amount)` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `role` enum('Manager','Barista','Owner') NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `date_hired` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `full_name`, `role`, `status`, `date_hired`) VALUES
(1, 'Juan Dela Cruz', 'Owner', 'Active', '2023-01-15'),
(2, 'Maria Clara', 'Manager', 'Active', '2023-02-01'),
(3, 'Jose Rizal', 'Barista', 'Active', '2023-03-10'),
(4, 'Andres Bonifacio', 'Barista', 'Active', '2023-06-20'),
(5, 'Apolinario Mabini', 'Barista', 'Inactive', '2023-01-20');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `item_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_name` varchar(100) NOT NULL,
  `quantity_on_hand` decimal(10,2) DEFAULT 0.00,
  `unit_measurement` varchar(20) NOT NULL,
  `reorder_point` int(11) DEFAULT 10,
  `expiration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`item_id`, `supplier_id`, `item_name`, `quantity_on_hand`, `unit_measurement`, `reorder_point`, `expiration_date`) VALUES
(1, 1, 'Dark Choco Powder', 25.00, 'kg', 5, '2024-12-30'),
(2, 1, 'Wintermelon Syrup', 15.00, 'liters', 5, '2024-10-15'),
(3, 2, 'Fresh Milk', 12.00, 'liters', 10, '2023-11-05'),
(4, 1, 'Tapioca Pearls', 2.00, 'kg', 10, '2023-10-30'),
(5, 3, '22oz Cups', 40.00, 'pcs', 100, NULL),
(6, 3, '16oz Cups', 500.00, 'pcs', 100, NULL),
(7, 1, 'Matcha Powder', 8.00, 'kg', 3, '2024-08-20'),
(8, 2, 'White Sugar', 50.00, 'kg', 10, '2025-01-01'),
(9, 1, 'Passion Fruit Jam', 10.00, 'kg', 5, '2024-06-15');

-- --------------------------------------------------------

--
-- Stand-in structure for view `low_stock_alert`
-- (See below for the actual view)
--
CREATE TABLE `low_stock_alert` (
`item_name` varchar(100)
,`quantity_on_hand` decimal(10,2)
,`reorder_point` int(11)
,`supplier` varchar(100)
,`contact_number` varchar(20)
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `transaction_date` datetime DEFAULT current_timestamp(),
  `payment_method` enum('Cash','Online Payment') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `employee_id`, `transaction_date`, `payment_method`, `total_amount`) VALUES
(1, 3, '2023-10-25 09:30:00', 'Cash', 200.00),
(2, 3, '2023-10-25 10:15:00', 'Cash', 95.00),
(3, 4, '2023-10-25 12:00:00', 'Online Payment', 280.00),
(4, 3, '2023-10-25 14:30:00', 'Cash', 190.00),
(5, 4, '2023-10-25 16:45:00', 'Online Payment', 450.00),
(6, 3, '2023-10-26 10:00:00', 'Online Payment', 185.00),
(7, 3, '2023-10-26 11:30:00', 'Online Payment', 90.00),
(8, 4, '2023-10-26 15:00:00', 'Cash', 85.00),
(9, 2, '2025-11-27 21:20:26', 'Cash', 500.00),
(10, 2, '2025-11-27 21:20:26', 'Cash', 140.00),
(11, 3, '2025-11-27 21:20:26', 'Online Payment', 200.00);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `detail_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`detail_id`, `order_id`, `product_id`, `quantity`, `subtotal`) VALUES
(1, 1, 2, 2, 200.00),
(2, 2, 4, 1, 95.00),
(3, 3, 8, 2, 280.00),
(4, 4, 4, 2, 190.00),
(5, 5, 2, 3, 300.00),
(6, 5, 5, 1, 110.00),
(7, 5, 10, 1, 40.00),
(8, 6, 4, 1, 95.00),
(9, 6, 6, 1, 90.00),
(10, 7, 6, 1, 90.00),
(11, 8, 1, 1, 85.00),
(12, 9, 2, 5, 500.00),
(13, 10, 8, 1, 140.00),
(14, 11, 2, 2, 200.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) NOT NULL,
  `size` enum('Solo','Jumbo') DEFAULT 'Solo',
  `unit_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `category_id`, `product_name`, `size`, `unit_price`) VALUES
(1, 1, 'Dark Choco Milk Tea', 'Solo', 85.00),
(2, 1, 'Dark Choco Milk Tea', 'Jumbo', 100.00),
(3, 1, 'Wintermelon Milk Tea', 'Solo', 80.00),
(4, 1, 'Wintermelon Milk Tea', 'Jumbo', 95.00),
(5, 1, 'Okinawa Milk Tea', 'Jumbo', 110.00),
(6, 2, 'Passion Fruit Tea', 'Jumbo', 90.00),
(7, 2, 'Lemon Green Tea', 'Jumbo', 85.00),
(8, 3, 'Matcha Frappe', 'Jumbo', 140.00),
(9, 3, 'Mocha Frappe', 'Jumbo', 130.00),
(10, 4, 'Yakult Lemon', 'Solo', 75.00);

-- --------------------------------------------------------

--
-- Table structure for table `product_recipes`
--

CREATE TABLE `product_recipes` (
  `recipe_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity_required` decimal(10,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_recipes`
--

INSERT INTO `product_recipes` (`recipe_id`, `product_id`, `item_id`, `quantity_required`) VALUES
(1, 2, 1, 0.0500),
(2, 2, 5, 1.0000),
(3, 4, 2, 0.0400),
(4, 4, 5, 1.0000);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `company_name` varchar(100) NOT NULL,
  `contact_person` varchar(100) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `company_name`, `contact_person`, `contact_number`, `address`) VALUES
(1, 'EasyBev Philippines', 'Mr. Jonathan Tan', '0917-555-0101', 'Quezon City, Metro Manila'),
(2, 'Famy Local Market', 'Aling Rosa', '0998-222-3333', 'Famy Public Market, Laguna'),
(3, 'Cup & Straw Depot', 'Ms. Sarah Lee', '0917-888-9999', 'San Pablo City, Laguna');

-- --------------------------------------------------------

--
-- Structure for view `best_selling_products`
--
DROP TABLE IF EXISTS `best_selling_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `best_selling_products`  AS SELECT `p`.`product_name` AS `product_name`, sum(`od`.`quantity`) AS `Total_Sold` FROM (`products` `p` join `order_details` `od` on(`p`.`product_id` = `od`.`product_id`)) GROUP BY `p`.`product_name` ORDER BY sum(`od`.`quantity`) DESC ;

-- --------------------------------------------------------

--
-- Structure for view `daily_sales_summary`
--
DROP TABLE IF EXISTS `daily_sales_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daily_sales_summary`  AS SELECT cast(`orders`.`transaction_date` as date) AS `DATE(transaction_date)`, `orders`.`payment_method` AS `payment_method`, sum(`orders`.`total_amount`) AS `SUM(total_amount)` FROM `orders` GROUP BY cast(`orders`.`transaction_date` as date), `orders`.`payment_method` ;

-- --------------------------------------------------------

--
-- Structure for view `low_stock_alert`
--
DROP TABLE IF EXISTS `low_stock_alert`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `low_stock_alert`  AS SELECT `i`.`item_name` AS `item_name`, `i`.`quantity_on_hand` AS `quantity_on_hand`, `i`.`reorder_point` AS `reorder_point`, `s`.`company_name` AS `supplier`, `s`.`contact_number` AS `contact_number` FROM (`inventory` `i` join `suppliers` `s` on(`i`.`supplier_id` = `s`.`supplier_id`)) WHERE `i`.`quantity_on_hand` <= `i`.`reorder_point` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `employee_id` (`employee_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_recipes`
--
ALTER TABLE `product_recipes`
  ADD PRIMARY KEY (`recipe_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product_recipes`
--
ALTER TABLE `product_recipes`
  MODIFY `recipe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`) ON DELETE SET NULL;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL;

--
-- Constraints for table `product_recipes`
--
ALTER TABLE `product_recipes`
  ADD CONSTRAINT `product_recipes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_recipes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `inventory` (`item_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
