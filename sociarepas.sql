-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 03-06-2025 a las 17:40:46
-- Versión del servidor: 10.11.11-MariaDB-0+deb12u1
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sociarepas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add supplier', 7, 'add_supplier'),
(26, 'Can change supplier', 7, 'change_supplier'),
(27, 'Can delete supplier', 7, 'delete_supplier'),
(28, 'Can view supplier', 7, 'view_supplier'),
(29, 'Can add food_ filling', 8, 'add_food_filling'),
(30, 'Can change food_ filling', 8, 'change_food_filling'),
(31, 'Can delete food_ filling', 8, 'delete_food_filling'),
(32, 'Can view food_ filling', 8, 'view_food_filling'),
(33, 'Can add stock', 9, 'add_stock'),
(34, 'Can change stock', 9, 'change_stock'),
(35, 'Can delete stock', 9, 'delete_stock'),
(36, 'Can view stock', 9, 'view_stock'),
(37, 'Can add food_ type', 10, 'add_food_type'),
(38, 'Can change food_ type', 10, 'change_food_type'),
(39, 'Can delete food_ type', 10, 'delete_food_type'),
(40, 'Can view food_ type', 10, 'view_food_type'),
(41, 'Can add client', 11, 'add_client'),
(42, 'Can change client', 11, 'change_client'),
(43, 'Can delete client', 11, 'delete_client'),
(44, 'Can view client', 11, 'view_client'),
(45, 'Can add payment_ type', 12, 'add_payment_type'),
(46, 'Can change payment_ type', 12, 'change_payment_type'),
(47, 'Can delete payment_ type', 12, 'delete_payment_type'),
(48, 'Can view payment_ type', 12, 'view_payment_type'),
(49, 'Can add order', 13, 'add_order'),
(50, 'Can change order', 13, 'change_order'),
(51, 'Can delete order', 13, 'delete_order'),
(52, 'Can view order', 13, 'view_order'),
(53, 'Can add order_ details', 14, 'add_order_details'),
(54, 'Can change order_ details', 14, 'change_order_details'),
(55, 'Can delete order_ details', 14, 'delete_order_details'),
(56, 'Can view order_ details', 14, 'view_order_details'),
(57, 'Can add food_ filling_ type_ details', 15, 'add_food_filling_type_details'),
(58, 'Can change food_ filling_ type_ details', 15, 'change_food_filling_type_details'),
(59, 'Can delete food_ filling_ type_ details', 15, 'delete_food_filling_type_details'),
(60, 'Can view food_ filling_ type_ details', 15, 'view_food_filling_type_details');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `client`
--

CREATE TABLE `client` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `phone_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'food_filling', 'food_filling'),
(15, 'food_filling', 'food_filling_type_details'),
(9, 'food_filling', 'stock'),
(7, 'food_filling', 'supplier'),
(10, 'food_type', 'food_type'),
(11, 'order', 'client'),
(13, 'order', 'order'),
(14, 'order', 'order_details'),
(12, 'order', 'payment_type'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-06-03 13:13:31.953270'),
(2, 'auth', '0001_initial', '2025-06-03 13:13:32.765277'),
(3, 'admin', '0001_initial', '2025-06-03 13:13:32.871735'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-06-03 13:13:32.894362'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-03 13:13:32.923582'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-06-03 13:13:33.011773'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-06-03 13:13:33.063566'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-06-03 13:13:33.102934'),
(9, 'auth', '0004_alter_user_username_opts', '2025-06-03 13:13:33.131113'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-06-03 13:13:33.183854'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-06-03 13:13:33.186653'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-06-03 13:13:33.212349'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-06-03 13:13:33.251354'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-06-03 13:13:33.293782'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-06-03 13:13:33.330168'),
(16, 'auth', '0011_update_proxy_permissions', '2025-06-03 13:13:33.353622'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-06-03 13:13:33.391909'),
(18, 'food_type', '0001_initial', '2025-06-03 13:13:33.408298'),
(19, 'food_filling', '0001_initial', '2025-06-03 13:13:33.535283'),
(20, 'order', '0001_initial', '2025-06-03 13:13:33.721655'),
(21, 'sessions', '0001_initial', '2025-06-03 13:13:33.755774'),
(22, 'food_filling', '0002_remove_supplier_name_supplier_supplier', '2025-06-03 14:37:02.688566'),
(23, 'order', '0002_remove_payment_type_name_payment_type_payment_type', '2025-06-03 14:37:02.741770'),
(24, 'food_filling', '0003_food_filling_type_details', '2025-06-03 14:58:16.722038'),
(25, 'food_filling', '0004_remove_food_filling_fk_food_type', '2025-06-03 14:59:11.590748'),
(26, 'food_filling', '0005_food_filling_quantity', '2025-06-03 15:17:13.378904');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_filling`
--

CREATE TABLE `food_filling` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `food_filling`
--

INSERT INTO `food_filling` (`id`, `name`, `quantity`) VALUES
(1, 'Queso amarillo', 100),
(2, 'Queso guayanés', 100),
(3, 'Queso blanco', 100),
(4, 'Huevo', 100),
(5, 'Pollo', 100),
(6, 'Caraotas', 100),
(7, 'Carne molida', 100),
(8, 'Cebolla', 100),
(9, 'Tomate', 100),
(10, 'Lechuga', 100),
(11, 'Carne de res', 100),
(12, 'Aguacate', 100),
(13, 'Carne mechada', 100),
(14, 'Tajadas', 100),
(15, 'Ají dulce', 100),
(16, 'Pernil de cerdo', 100),
(17, 'Mayonesa', 100),
(18, 'Salsa de tomate', 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_filling_food_filling_type_details`
--

CREATE TABLE `food_filling_food_filling_type_details` (
  `id` bigint(20) NOT NULL,
  `fk_food_filling_id` bigint(20) NOT NULL,
  `fk_food_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `food_filling_food_filling_type_details`
--

INSERT INTO `food_filling_food_filling_type_details` (`id`, `fk_food_filling_id`, `fk_food_type_id`) VALUES
(1, 4, 1),
(2, 5, 2),
(3, 1, 2),
(4, 6, 3),
(5, 3, 3),
(6, 18, 4),
(7, 8, 4),
(8, 7, 4),
(9, 9, 4),
(10, 10, 4),
(11, 17, 4),
(17, 11, 5),
(18, 9, 5),
(19, 12, 5),
(20, 2, 5),
(21, 13, 6),
(22, 6, 6),
(23, 14, 6),
(24, 3, 6),
(25, 3, 7),
(26, 6, 7),
(27, 12, 7),
(28, 13, 8),
(29, 1, 8),
(30, 4, 9),
(31, 8, 9),
(32, 9, 9),
(33, 15, 9),
(34, 16, 10),
(35, 9, 10),
(36, 17, 10),
(40, 5, 11),
(41, 17, 11),
(42, 12, 11),
(43, 16, 12),
(44, 1, 12),
(45, 11, 13),
(46, 3, 13),
(47, 12, 13);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_type`
--

CREATE TABLE `food_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `food_type`
--

INSERT INTO `food_type` (`id`, `name`, `price`) VALUES
(1, 'A Caballo', 5),
(2, 'Catira', 4),
(3, 'Dominó', 6),
(4, 'Gringa', 8),
(5, 'Llanera', 3),
(6, 'Pabellón', 8),
(7, 'Patapata', 9),
(8, 'Pelúa', 4),
(9, 'Perico', 3),
(10, 'Pernil', 2),
(11, 'Reina Pepeada', 6),
(12, 'Rumbera', 7),
(13, 'Santa Bárbara', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order`
--

CREATE TABLE `order` (
  `id` bigint(20) NOT NULL,
  `total` int(11) NOT NULL,
  `fk_client_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `fk_food_type_id` bigint(20) NOT NULL,
  `fk_order_id` bigint(20) NOT NULL,
  `fk_payment_type_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment_type`
--

CREATE TABLE `payment_type` (
  `id` bigint(20) NOT NULL,
  `payment_type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payment_type`
--

INSERT INTO `payment_type` (`id`, `payment_type`) VALUES
(1, 1),
(2, 2),
(3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `fk_food_type_id` bigint(20) NOT NULL,
  `fk_supplier_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplier`
--

CREATE TABLE `supplier` (
  `id` bigint(20) NOT NULL,
  `supplier` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `supplier`
--

INSERT INTO `supplier` (`id`, `supplier`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `food_filling`
--
ALTER TABLE `food_filling`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `food_filling_food_filling_type_details`
--
ALTER TABLE `food_filling_food_filling_type_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_filling_food_fi_fk_food_filling_id_e110e467_fk_food_fill` (`fk_food_filling_id`),
  ADD KEY `food_filling_food_fi_fk_food_type_id_82aa53c3_fk_food_type` (`fk_food_type_id`);

--
-- Indices de la tabla `food_type`
--
ALTER TABLE `food_type`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_fk_client_id_4ffa7630_fk_client_id` (`fk_client_id`);

--
-- Indices de la tabla `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_details_fk_food_type_id_dfd5bb79_fk_food_type_id` (`fk_food_type_id`),
  ADD KEY `order_details_fk_order_id_2dad560a_fk_order_id` (`fk_order_id`),
  ADD KEY `order_details_fk_payment_type_id_88b81a91_fk_payment_type_id` (`fk_payment_type_id`);

--
-- Indices de la tabla `payment_type`
--
ALTER TABLE `payment_type`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_fk_food_type_id_01bcd55d_fk_food_type_id` (`fk_food_type_id`),
  ADD KEY `stock_fk_supplier_id_f9435ece_fk_supplier_id` (`fk_supplier_id`);

--
-- Indices de la tabla `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `client`
--
ALTER TABLE `client`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `food_filling`
--
ALTER TABLE `food_filling`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `food_filling_food_filling_type_details`
--
ALTER TABLE `food_filling_food_filling_type_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT de la tabla `food_type`
--
ALTER TABLE `food_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `order`
--
ALTER TABLE `order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payment_type`
--
ALTER TABLE `payment_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `food_filling_food_filling_type_details`
--
ALTER TABLE `food_filling_food_filling_type_details`
  ADD CONSTRAINT `food_filling_food_fi_fk_food_filling_id_e110e467_fk_food_fill` FOREIGN KEY (`fk_food_filling_id`) REFERENCES `food_filling` (`id`),
  ADD CONSTRAINT `food_filling_food_fi_fk_food_type_id_82aa53c3_fk_food_type` FOREIGN KEY (`fk_food_type_id`) REFERENCES `food_type` (`id`);

--
-- Filtros para la tabla `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_fk_client_id_4ffa7630_fk_client_id` FOREIGN KEY (`fk_client_id`) REFERENCES `client` (`id`);

--
-- Filtros para la tabla `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_fk_food_type_id_dfd5bb79_fk_food_type_id` FOREIGN KEY (`fk_food_type_id`) REFERENCES `food_type` (`id`),
  ADD CONSTRAINT `order_details_fk_order_id_2dad560a_fk_order_id` FOREIGN KEY (`fk_order_id`) REFERENCES `order` (`id`),
  ADD CONSTRAINT `order_details_fk_payment_type_id_88b81a91_fk_payment_type_id` FOREIGN KEY (`fk_payment_type_id`) REFERENCES `payment_type` (`id`);

--
-- Filtros para la tabla `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `stock_fk_food_type_id_01bcd55d_fk_food_type_id` FOREIGN KEY (`fk_food_type_id`) REFERENCES `food_type` (`id`),
  ADD CONSTRAINT `stock_fk_supplier_id_f9435ece_fk_supplier_id` FOREIGN KEY (`fk_supplier_id`) REFERENCES `supplier` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
