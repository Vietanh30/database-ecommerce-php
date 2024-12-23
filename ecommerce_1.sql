SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Tạo bảng `cart`
CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `amount` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tạo bảng `categories`
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tạo bảng `flashsale`
CREATE TABLE `flashsale` (
  `id` int(11) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `percent` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Tạo bảng `products`
CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cost_price` decimal(10,2) NOT NULL,
  `selling_price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tạo bảng `roles`
CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Chèn dữ liệu vào bảng `roles`
INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'administrator', '2024-11-21 18:42:06', '2024-11-21 18:42:06'),
(2, 'user', 'user', '2024-11-21 18:42:06', '2024-11-21 18:42:06');

-- Tạo bảng `users`
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Chỉ mục cho bảng `cart`
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

-- Chỉ mục cho bảng `categories`
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `flashsale`
ALTER TABLE `flashsale`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `products`
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

-- Chỉ mục cho bảng `roles`
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

-- Chỉ mục cho bảng `users`
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

-- Cập nhật bảng `cart` để sử dụng AUTO_INCREMENT
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

ALTER TABLE `flashsale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

-- Thiết lập khóa ngoại cho `cart`
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

-- Thiết lập khóa ngoại cho `products`
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

-- Thiết lập khóa ngoại cho `users`
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

COMMIT;

INSERT INTO categories (id, name, image) VALUES
(1, 'Laptop', './assets/Categories/laptop-category.png'),
(2, 'iPhone', './assets/Categories/iphone-category.png'),
(3, 'Apple Watch', './assets/Categories/apple-watch-category.png'),
(4, 'Camera', './assets/Categories/camera-category.png'),
(5, 'Máy tính bảng', './assets/Categories/tablet-category.png'),
(6, 'Màn hình PC', './assets/Categories/monitor-category.png');

INSERT INTO products (id, category_id, name, description, cost_price, selling_price, image, quantity) VALUES
(49, 3, 'Đồng hồ thông minh Apple Watch SE 2 GPS 40mm viền nhôm', 'Apple Watch SE 2 GPS 40mm viền nhôm dây thể thao', 4800000.00, 5500000.00, '6752b0813c17d.jpg', 30),
(50, 3, 'Apple Watch Series 10 42mm viền nhôm dây thể thao', 'Được ra mắt vào tháng 9/2024, Apple Watch Series 10 42mm viền nhôm dây thể thao', 9000000.00, 11500000.00, '6752b143b3bdd.jpg', 20),
(51, 3, 'Đồng hồ thông minh Apple Watch SE 2 GPS + Cellular 40mm', 'Apple Watch SE 2 GPS + Cellular 40mm viền nhôm dây thể thao', 6000000.00, 8000000.00, '6752bf4a6099a.jpg,6752bf4a60d81.jpg', 15),
(52, 3, 'Đồng hồ thông minh Apple Watch SE 2 GPS 44mm viền nhôm', 'Apple Watch SE 2 GPS 44mm viền nhôm dây thể thao cực kỳ sang trọng', 5000000.00, 7000000.00, '6753aeec617cd.jpg', 10),
(53, 3, 'Apple Watch Series 10 46mm viền nhôm dây thể thao', 'Apple Watch Series 10 46mm đem đến cho người dùng trải nghiệm tốt nhất', 9000000.00, 13000000.00, '6753af1f19b8d.jpg', 15),
(54, 3, 'Apple Watch Series 10 46mm viền nhôm dây vải', 'Phiên bản Apple Watch Series 10 46mm dây vải mới kèm nhiều tính năng', 9000000.00, 13500000.00, '6753af62b2ff2.jpg', 25),
(55, 3, 'Apple Watch Series 10 42mm viền nhôm dây vải', 'Apple Watch Series 10 vẫn sở hữu mặt đồng hồ hình chữ nhật hiện đại', 8500000.00, 12000000.00, '6753af9fcb451.jpg', 12),
(56, 3, 'Đồng hồ thông minh Apple Watch Series 9 GPS 45mm', 'Vẫn mang vẻ ngoài tinh tế với màn hình tràn viền và nhiều tính năng', 8000000.00, 12500000.00, '6753afeccc1f7.jpg', 20),
(57, 3, 'Đồng hồ thông minh Apple Watch SE 2 GPS 40mm viền nhôm', 'Thiết kế tối giản mà đậm chất xu hướng, mẫu đồng hồ mới nhất', 4000000.00, 6500000.00, '6753b01ad8ecf.jpg', 20),
(58, 3, 'Apple Watch Series 10 GPS + Cellular 42mm', 'Có đôi chút thay đổi nhỏ trong thiết kế, nhưng vẫn giữ được phong cách', 11000000.00, 14900000.00, '6753b04c5fbd6.jpg', 25),
(59, 1, 'Laptop Asus Vivobook Go 15 E1504FA R5 7520U/16GB/512GB', 'Laptop Asus Vivobook Go 15 với hiệu suất mạnh mẽ', 9000000.00, 14500000.00, '6753b0883d9b1.jpg', 10),
(60, 1, 'Laptop HP 15 fc0085AU R5 7430U/16GB/512GB/Win11', 'Laptop HP 15 với thiết kế tinh tế và hiệu suất cao', 10000000.00, 14900000.00, '6753b0c5e9414.jpg', 15),
(61, 1, 'Laptop Dell Inspiron 15 3520 i5 1235U/16GB/512GB/1TB', 'Laptop Dell Inspiron 15 với cấu hình mạnh mẽ', 13000000.00, 17900000.00, '6753b0f2ce102.jpg', 10),
(62, 1, 'Laptop Asus Vivobook 15 X1504ZA i3 1215U/8GB/512GB', 'Laptop Asus Vivobook 15 với thiết kế mỏng nhẹ', 7000000.00, 12000000.00, '6753b1214a479.jpg', 25),
(63, 1, 'Laptop Asus Vivobook 15 OLED A1505ZA i5 12500H/16GB/512GB', 'Laptop Asus Vivobook 15 OLED với màn hình sống động', 13000000.00, 18000000.00, '6753b15c41f18.jpg', 10),
(64, 1, 'Laptop HP 15 fd0303TU i3 1315U/8GB/512GB/Win11', 'Laptop HP 15 với hiệu suất tốt cho công việc và học tập', 8000000.00, 13500000.00, '6753b1942836e.jpg', 11),
(65, 1, 'Laptop Dell Inspiron 15 3520 i5 1235U/16GB/512GB/1TB', 'Laptop Dell với cấu hình mạnh mẽ cho mọi nhu cầu', 8500000.00, 12000000.00, '6753b1dc1fca7.jpg', 12),
(66, 1, 'Laptop Lenovo Ideapad Slim 3 15IAH8 i5 12450H/16GB/512GB', 'Laptop Lenovo Ideapad với thiết kế sang trọng', 11000000.00, 15900000.00, '6753b2c7b745e.jpg', 10),
(67, 1, 'Laptop Acer Aspire 3 A315 58 529V i5 1135G7/8GB/256GB', 'Laptop Acer với hiệu suất ổn định cho học tập', 6500000.00, 10990000.00, '6753b2f24726b.jpg', 12),
(68, 1, 'Laptop Asus Gaming Vivobook K3605ZF i5 12500H/16GB/1TB', 'Laptop Gaming với cấu hình mạnh mẽ cho game thủ', 15000000.00, 19900000.00, '6753b31a2a300.jpg', 20),
(69, 2, 'Điện thoại iPhone 16 Pro Max 256GB', 'iPhone 16 khẳng định vị thế của Apple trong thế giới smartphone', 30000000.00, 36000000.00, '6753b34abdc36.jpg', 22),
(70, 2, 'Điện thoại iPhone 16 Pro Max 512GB', 'IPhone với những cải tiến vượt bậc về thiết kế và hiệu suất', 37000000.00, 43000000.00, '6753b3793a342.jpg', 25),
(71, 2, 'Điện thoại iPhone 16 Pro Max 1TB', 'Đây không chỉ là thiết bị điện tử, mà còn là sự sáng tạo của công nghệ', 43000000.00, 49900000.00, '6753b3b1462ee.jpg', 20),
(72, 2, 'Điện thoại iPhone 16 Pro 256GB', 'Sự kết hợp hoàn hảo giữa thiết kế hiện đại và công nghệ', 29000000.00, 33000000.00, '6753b3dde9ae9.jpg', 12),
(73, 2, 'Điện thoại iPhone 16 Pro 512GB', 'Chiếc điện thoại biểu tượng của sự hoàn hảo', 35000000.00, 39990000.00, '6753b409933e7.jpg', 12),
(74, 2, 'Điện thoại iPhone 16 Plus 128GB', 'IPhone 16 Plus với thiết kế vuông vắn đặc trưng', 23000000.00, 27000000.00, '6753bf7d91f46.jpg', 10),
(75, 2, 'Điện thoại iPhone 16 Plus 256GB', 'Sức mạnh của iPhone 16 Plus nằm ở bộ vi xử lý A18', 26000000.00, 29990000.00, '6753c092c5bc6.jpg', 16),
(76, 2, 'Điện thoại iPhone 16 Plus 512GB', 'IPhone 16 Plus tiếp tục duy trì thiết kế vuông vắn', 30000000.00, 34990000.00, '6753c0c814697.jpg', 10),
(77, 2, 'Điện thoại iPhone 16 128GB', 'Kết hợp cùng khung viền là mặt lưng kính pha màu thời thượng', 20000000.00, 22990000.00, '6753c0ee20c0c.jpg', 20),
(78, 2, 'Điện thoại iPhone 16 512GB', 'Một trong những điểm nhấn nổi bật nhất của chiếc smartphone mới', 27000000.00, 31990000.00, '6753c131902f5.jpg', 10),
(79, 4, 'Camera IP 360 Độ 3MP IMOU TA32CP-L', 'Camera với thiết kế mềm mại và tính năng hiện đại', 300000.00, 650000.00, '6753c166c5bed.jpg', 10),
(80, 4, 'Camera IP 360 Độ 2MP TIANDY TC-H322N', 'Camera sở hữu kiểu dáng đẹp mắt và tính năng thông minh', 250000.00, 450000.00, '6753c196db845.jpg', 10),
(81, 4, 'Camera IP 360 Độ 2MP TP-Link Tapo C200C', 'Sở hữu gam màu trắng tinh tế và tính năng hiện đại', 250000.00, 490000.00, '6753c1bf6833a.jpg', 10);


INSERT INTO flashsale (id, product_id, percent, start_time, end_time) VALUES
(5, 49, 20, '2024-12-06 17:36:00', '2024-12-06 17:37:00'),
(7, 50, 15, '2024-12-06 17:41:00', '2024-12-06 21:41:00'),
(8, 51, 12, '2024-12-06 18:42:00', '2024-12-06 19:42:00'),
(9, 76, 10, '2024-12-07 10:34:00', '2024-12-08 10:34:00'),
(10, 79, 15, '2024-12-07 10:34:00', '2024-12-08 10:34:00');