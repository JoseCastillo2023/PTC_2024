-- Eliminación base de datos
DROP DATABASE IF EXISTS PanaderiaHPTC;

-- Creación base de datos 
CREATE DATABASE PanaderiaHPTC;

USE PanaderiaHPTC;

-- Tabla Clientes
CREATE TABLE tb_clientes (
  id_cliente INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido_cliente VARCHAR(50) NOT NULL,
  dui_cliente VARCHAR(10) NOT NULL UNIQUE,
  correo_cliente VARCHAR(100) NOT NULL UNIQUE,
  telefono_cliente VARCHAR(9) NOT NULL,
  direccion_cliente VARCHAR(250) NOT NULL,
  nacimiento_cliente DATE NOT NULL,
  clave_cliente VARCHAR(100) NOT NULL,
  estado_cliente TINYINT(1) NOT NULL DEFAULT 1,
  fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  codigo_recuperacion VARCHAR(6) NOT NULL,
  fecha_expiracion_codigo DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Categorías
CREATE TABLE tb_categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(25) NOT NULL UNIQUE,
    descripcion_categoria VARCHAR(150) NOT NULL,
    imagen_categoria VARCHAR(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Productos
CREATE TABLE tb_productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    precio_producto DECIMAL(10,2) NOT NULL CHECK (precio_producto >= 0),
    existencias_producto INT UNSIGNED NOT NULL CHECK (existencias_producto >= 0),
    imagen_producto VARCHAR(250) NOT NULL,
    id_categoria INT NOT NULL,
    estado_producto TINYINT(1) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (nombre_producto, id_categoria),
    FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Administradores
CREATE TABLE tb_administradores (
    id_administrador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_administrador VARCHAR(50) NOT NULL,
    apellido_administrador VARCHAR(50) NOT NULL,
    correo_administrador VARCHAR(100) NOT NULL UNIQUE,
    alias_administrador VARCHAR(30) UNIQUE NOT NULL,
    clave_administrador VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Pedidos
CREATE TABLE tb_pedidos (
  id_pedido INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_cliente INT NOT NULL,
  direccion_pedido VARCHAR(250) NOT NULL,
  estado_pedido ENUM('Pendiente','En camino','Finalizado') NOT NULL CHECK (estado_pedido IN ('Pendiente', 'En camino', 'Finalizado')),
  fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Detalles Pedidos
CREATE TABLE tb_detalles_pedidos (
  id_detalle INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_producto INT(10) NOT NULL,
  cantidad_producto SMALLINT(6) UNSIGNED NOT NULL CHECK (cantidad_producto > 0),
  precio_producto DECIMAL(10,2) UNSIGNED NOT NULL CHECK (precio_producto >= 0),
  id_pedido INT NOT NULL,
  FOREIGN KEY (id_pedido) REFERENCES tb_pedidos(id_pedido),
  FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Tabla Valoraciones
CREATE TABLE tb_valoraciones (
    id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
    id_detalle INT NOT NULL,
    calificacion_producto INT CHECK (calificacion_producto BETWEEN 1 AND 5),
    comentario_producto VARCHAR(250),
    fecha_valoracion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_comentario BOOLEAN DEFAULT TRUE NOT NULL,
    FOREIGN KEY (id_detalle) REFERENCES tb_detalles_pedidos(id_detalle)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;