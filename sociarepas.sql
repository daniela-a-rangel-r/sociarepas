-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-06-2025 a las 17:03:55
-- Versión del servidor: 11.7.2-MariaDB
-- Versión de PHP: 8.2.12

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
(37, 'Can add food_ filling_ type_ details', 10, 'add_food_filling_type_details'),
(38, 'Can change food_ filling_ type_ details', 10, 'change_food_filling_type_details'),
(39, 'Can delete food_ filling_ type_ details', 10, 'delete_food_filling_type_details'),
(40, 'Can view food_ filling_ type_ details', 10, 'view_food_filling_type_details'),
(41, 'Can add food_ type', 11, 'add_food_type'),
(42, 'Can change food_ type', 11, 'change_food_type'),
(43, 'Can delete food_ type', 11, 'delete_food_type'),
(44, 'Can view food_ type', 11, 'view_food_type'),
(45, 'Can add client', 12, 'add_client'),
(46, 'Can change client', 12, 'change_client'),
(47, 'Can delete client', 12, 'delete_client'),
(48, 'Can view client', 12, 'view_client'),
(49, 'Can add payment_ type', 13, 'add_payment_type'),
(50, 'Can change payment_ type', 13, 'change_payment_type'),
(51, 'Can delete payment_ type', 13, 'delete_payment_type'),
(52, 'Can view payment_ type', 13, 'view_payment_type'),
(53, 'Can add order', 14, 'add_order'),
(54, 'Can change order', 14, 'change_order'),
(55, 'Can delete order', 14, 'delete_order'),
(56, 'Can view order', 14, 'view_order'),
(57, 'Can add order_ details', 15, 'add_order_details'),
(58, 'Can change order_ details', 15, 'change_order_details'),
(59, 'Can delete order_ details', 15, 'delete_order_details'),
(60, 'Can view order_ details', 15, 'view_order_details');

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

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1000000$ml7ItFdF5mCZey1220mxPp$ZuKduX4rbzygxmWi5Pf1N8cKHJSy4fCPa8VZfFkExZY=', '2025-06-12 15:01:22.286867', 1, 'arepamaster', '', '', 'a@gmail.com', 1, 1, '2025-06-10 00:07:07.582254'),
(2, 'pbkdf2_sha256$1000000$LekvdQ8n5IOxG4BnTDl5Aw$GXXBIug2fnQVmQhIcZgwdcrJxhA+dcS0S9rJn1YL7QY=', '2025-06-12 14:59:32.880765', 0, 'arepauser', '', '', 'user@gmail.com', 1, 1, '2025-06-12 14:45:02.787923');

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
  `phone_number` int(11) NOT NULL,
  `identity_number` int(11) NOT NULL
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
(10, 'food_filling', 'food_filling_type_details'),
(9, 'food_filling', 'stock'),
(7, 'food_filling', 'supplier'),
(11, 'food_type', 'food_type'),
(12, 'order', 'client'),
(14, 'order', 'order'),
(15, 'order', 'order_details'),
(13, 'order', 'payment_type'),
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
(1, 'contenttypes', '0001_initial', '2025-06-10 00:03:42.724697'),
(2, 'auth', '0001_initial', '2025-06-10 00:04:07.004346'),
(3, 'admin', '0001_initial', '2025-06-10 00:04:11.921461'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-06-10 00:04:11.989820'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-06-10 00:04:12.142394'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-06-10 00:04:15.687031'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-06-10 00:04:17.804626'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-06-10 00:04:18.995271'),
(9, 'auth', '0004_alter_user_username_opts', '2025-06-10 00:04:19.054360'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-06-10 00:04:21.296083'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-06-10 00:04:21.371626'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-06-10 00:04:21.416289'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-06-10 00:04:22.895773'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-06-10 00:04:24.228264'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-06-10 00:04:25.829888'),
(16, 'auth', '0011_update_proxy_permissions', '2025-06-10 00:04:25.904140'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-06-10 00:04:27.399439'),
(18, 'food_type', '0001_initial', '2025-06-10 00:04:27.994616'),
(19, 'food_filling', '0001_initial', '2025-06-10 00:04:38.394960'),
(20, 'food_filling', '0002_remove_supplier_name_supplier_supplier', '2025-06-10 00:04:42.552114'),
(21, 'food_filling', '0003_food_filling_type_details', '2025-06-10 00:04:48.855189'),
(22, 'food_filling', '0004_remove_food_filling_fk_food_type', '2025-06-10 00:04:59.555073'),
(23, 'food_filling', '0005_food_filling_quantity', '2025-06-10 00:05:01.408952'),
(24, 'food_filling', '0006_remove_stock_fk_food_type_stock_fk_food_filling', '2025-06-10 00:05:09.943397'),
(25, 'food_filling', '0007_food_filling_type_details_needed_quantity_and_more', '2025-06-10 00:05:13.080661'),
(26, 'food_filling', '0008_alter_food_filling_quantity_stockrequest', '2025-06-10 00:05:18.134039'),
(27, 'food_filling', '0009_remove_food_filling_quantity_and_more', '2025-06-10 00:05:20.899722'),
(28, 'food_filling', '0010_delete_stockrequest', '2025-06-10 00:05:21.719031'),
(29, 'food_filling', '0011_remove_supplier_supplier_supplier_address_and_more', '2025-06-10 00:05:33.965628'),
(30, 'food_type', '0002_alter_food_type_price', '2025-06-10 00:05:35.390527'),
(31, 'order', '0001_initial', '2025-06-10 00:05:48.956967'),
(32, 'order', '0002_remove_payment_type_name_payment_type_payment_type', '2025-06-10 00:05:50.890876'),
(33, 'order', '0003_client_identity_number', '2025-06-10 00:05:52.357282'),
(34, 'order', '0004_remove_payment_type_payment_type_payment_type_name', '2025-06-10 00:05:54.798478'),
(35, 'sessions', '0001_initial', '2025-06-10 00:05:56.056947'),
(36, 'food_filling', '0012_alter_supplier_phone_number', '2025-06-10 00:32:44.081115'),
(37, 'food_type', '0003_food_type_is_active', '2025-06-12 14:47:19.480254');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('71owe5f2eezqhad4wma695f8p0ec48s0', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uPjQg:THuS80joBMujndShyolysilqD-RET9lKahMAclL182Q', '2025-06-26 15:01:22.314541'),
('a6ptb0ap4k7iobw4yls334cdg6ul335w', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOmmy:uv61WirwkxfMIHAAANv8HNssqcBqVGI3yQNs1OJMLDE', '2025-06-24 00:24:28.732042'),
('g6rqvhz94tfn7ar316mev2guiseyv06z', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOmWa:ETijNr9bYE1s_iR_XTMDYJDAZDCqXfwp1oDYOcy1m9Q', '2025-06-24 00:07:32.979028'),
('ipwihrxz46z0xqsy8oz6hii15od0qu3f', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uPjQg:THuS80joBMujndShyolysilqD-RET9lKahMAclL182Q', '2025-06-26 15:01:22.322893'),
('jo053sih6g8kwuci83skppt7fhh0a6s3', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOpYV:zdGYf5HOrGdWosCZRHNmvIQ0b1Reuw6NXBbPEmJkGD4', '2025-06-24 03:21:43.475540'),
('ju3x4alc30cvo2kz597fp4o02xwaa3ny', '.eJxVjDsOwjAQBe_iGln-Z01JnzNYa6-NA8iR4qRC3J1ESgHtzLz3ZgG3tYat5yVMxK5Mscsvi5ieuR2CHtjuM09zW5cp8iPhp-18nCm_bmf7d1Cx132NRUMCM2BMyhVDHpXxVjoAr23JJIAsFhhoxxS1AY9ao7TWeSmEI_b5AuR1N1w:1uPjOv:-kAlmWk54eOtmnhbLEQX6Zpv0uM5kHHLM2eTNg48zrw', '2025-06-26 14:59:33.111242'),
('nrayy1748exlfjuzrd4bvghp7ffhq021', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOo7Q:Evpfa8ZZhzdJsue_d-gYQW4MFOlhVuWjwgOxDq2-dOs', '2025-06-24 01:49:40.929031'),
('nrb3fowyras22g3x90asmcqigs91m1an', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uPjDP:vt7IxxLwxy9IimGPFkSF-b4gwQmpzpWm9vlligZlat4', '2025-06-26 14:47:39.648701'),
('q8r2kgymt3bxb6daa3gbyebi3x8xf966', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOpYV:zdGYf5HOrGdWosCZRHNmvIQ0b1Reuw6NXBbPEmJkGD4', '2025-06-24 03:21:43.475798'),
('slcc8vng5wv7qy4yypsla9mr3fjakaju', '.eJxVjMsOwiAQRf-FtSE8hIJL9_0GMswMUjU0Ke3K-O_apAvd3nPOfYkE21rT1nlJE4mL0OL0u2XAB7cd0B3abZY4t3WZstwVedAux5n4eT3cv4MKvX7rqCN7ZMzZD8yFvGKlwVOwKjpjgSEYKq4odIzOnJ0pWVltsx0A2AXx_gAGAjiH:1uOmoh:juxa4eUNaUU-DpX0bx-sSGo8IGnXmtEXS6Y_3iE7D3s', '2025-06-24 00:26:15.667124'),
('y9xcgtothqpp58nx2bhx0olbefoowh4m', '.eJxVjDsOwjAQBe_iGln-Z01JnzNYa6-NA8iR4qRC3J1ESgHtzLz3ZgG3tYat5yVMxK5Mscsvi5ieuR2CHtjuM09zW5cp8iPhp-18nCm_bmf7d1Cx132NRUMCM2BMyhVDHpXxVjoAr23JJIAsFhhoxxS1AY9ao7TWeSmEI_b5AuR1N1w:1uPjO5:WHCVepYO7X8QJ8VgEK-8THsaR0qtmuIs8iaWw-i94NI', '2025-06-26 14:58:41.498304');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_filling`
--

CREATE TABLE `food_filling` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_filling_food_filling_type_details`
--

CREATE TABLE `food_filling_food_filling_type_details` (
  `id` bigint(20) NOT NULL,
  `fk_food_filling_id` bigint(20) NOT NULL,
  `fk_food_type_id` bigint(20) NOT NULL,
  `needed_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `food_type`
--

CREATE TABLE `food_type` (
  `id` bigint(20) NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` decimal(11,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `payment_type`
--

INSERT INTO `payment_type` (`id`, `name`) VALUES
(1, 'Pago Móvil'),
(2, 'Punto de Venta '),
(3, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `stock`
--

CREATE TABLE `stock` (
  `id` bigint(20) NOT NULL,
  `quantity` int(11) NOT NULL,
  `fk_supplier_id` bigint(20) NOT NULL,
  `fk_food_filling_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supplier`
--

CREATE TABLE `supplier` (
  `id` bigint(20) NOT NULL,
  `address` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `rif` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD KEY `stock_fk_supplier_id_f9435ece_fk_supplier_id` (`fk_supplier_id`),
  ADD KEY `stock_fk_food_filling_id_78639aad_fk_food_filling_id` (`fk_food_filling_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `food_filling`
--
ALTER TABLE `food_filling`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `food_filling_food_filling_type_details`
--
ALTER TABLE `food_filling_food_filling_type_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `food_type`
--
ALTER TABLE `food_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `order`
--
ALTER TABLE `order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `payment_type`
--
ALTER TABLE `payment_type`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `stock`
--
ALTER TABLE `stock`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `stock_fk_food_filling_id_78639aad_fk_food_filling_id` FOREIGN KEY (`fk_food_filling_id`) REFERENCES `food_filling` (`id`),
  ADD CONSTRAINT `stock_fk_supplier_id_f9435ece_fk_supplier_id` FOREIGN KEY (`fk_supplier_id`) REFERENCES `supplier` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
