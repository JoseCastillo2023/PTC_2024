-- Eliminación base de datos
DROP DATABASE IF EXISTS PanaderiaHPTC;

-- Creación base de datos 
CREATE DATABASE PanaderiaHPTC;

USE PanaderiaHPTC;

-- Tablas
CREATE TABLE tb_clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    apellido_cliente VARCHAR(50) NOT NULL,
    dui_cliente VARCHAR(10) NOT NULL,
    correo_cliente VARCHAR(100) NOT NULL,
    telefono_cliente VARCHAR(9) NOT NULL,
    direccion_cliente VARCHAR(250) NOT NULL,
    nacimiento_cliente DATE NOT NULL,
    clave_cliente VARCHAR(100) NOT NULL,
	estado_cliente BOOLEAN DEFAULT TRUE NOT NULL, 
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(25) NOT NULL,
    descripcion_categoria VARCHAR(150) NOT NULL,
    imagen_categoria VARCHAR(250) NOT NULL
);

CREATE TABLE tb_productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    precio_producto DECIMAL(10,2) NOT NULL,
    existencias_producto INT UNSIGNED NOT NULL,
    imagen_producto VARCHAR(250) NOT NULL,
    id_categoria INT NOT NULL,
    estado_producto TINYINT(1) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tb_administradores (
    id_administrador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_administrador VARCHAR(50) NOT NULL,
    apellido_administrador VARCHAR(50) NOT NULL,
    correo_administrador VARCHAR(100) NOT NULL,
    alias_administrador VARCHAR(30) UNIQUE NOT NULL,
    clave_administrador VARCHAR(100) NOT NULL
);

CREATE TABLE tb_valoraciones (
    id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
    id_detalle INT NOT NULL,
    calificacion_producto INT,
    comentario_producto VARCHAR(250),
    fecha_valoracion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_comentario BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE tb_ordenes (
    id_orden INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    forma_pago_pedido ENUM('Efectivo','Transferencia') DEFAULT 'Efectivo' NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    estado_pedido ENUM('Pendiente','Finalizado','Anulado') NOT NULL DEFAULT 'Pendiente'
);

CREATE TABLE tb_detalles_ordenes (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_producto INT NOT NULL CHECK (cantidad_producto > 0)
);