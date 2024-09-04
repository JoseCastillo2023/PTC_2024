-- Eliminación base de datos.
DROP DATABASE IF EXISTS PanaderiaHPTC;

-- Creación base de datos. 
CREATE DATABASE PanaderiaHPTC;

USE PanaderiaHPTC;


-- Creación de las tablas.

-- Tabla Clientes.
CREATE TABLE tb_clientes (
  id_cliente INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido_cliente VARCHAR(50) NOT NULL,
  dui_cliente VARCHAR(10) NOT NULL UNIQUE,
  correo_cliente VARCHAR(100) NOT NULL UNIQUE,
  telefono_cliente VARCHAR(9) NOT NULL UNIQUE,
  direccion_cliente VARCHAR(250) NOT NULL,
  nacimiento_cliente DATE NOT NULL,
  clave_cliente VARCHAR(100) NOT NULL,
  estado_cliente TINYINT(1) NOT NULL DEFAULT 1,
  fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  codigo_recuperacion VARCHAR(6) NOT NULL,
  fecha_expiracion_codigo DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Categorías.
CREATE TABLE tb_categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(25) NOT NULL UNIQUE,
    descripcion_categoria VARCHAR(150) NOT NULL,
    imagen_categoria VARCHAR(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Productos.
CREATE TABLE tb_productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    descripcion_producto VARCHAR(250) NOT NULL,
    precio_producto DECIMAL(10,2) NOT NULL CHECK (precio_producto >= 0),
    existencias_producto INT UNSIGNED NOT NULL CHECK (existencias_producto >= 0),
    imagen_producto VARCHAR(250) NOT NULL,
    id_categoria INT NOT NULL,
    estado_producto TINYINT(1) NOT NULL,
    fecha_registro TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Administradores.
CREATE TABLE tb_administradores (
    id_administrador INT PRIMARY KEY AUTO_INCREMENT,
    nombre_administrador VARCHAR(50) NOT NULL,
    apellido_administrador VARCHAR(50) NOT NULL,
    correo_administrador VARCHAR(100) NOT NULL UNIQUE,
    alias_administrador VARCHAR(30) UNIQUE NOT NULL,
    clave_administrador VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Pedidos.
CREATE TABLE tb_pedidos (
  id_pedido INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_cliente INT NOT NULL,
  direccion_pedido VARCHAR(250) NOT NULL,
  estado_pedido ENUM('Pendiente','En camino','Finalizado') NOT NULL CHECK (estado_pedido IN ('Pendiente', 'En camino', 'Finalizado')),
  fecha_registro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Tabla Detalles Pedidos.
CREATE TABLE tb_detalles_pedidos (
  id_detalle INT(10) AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_producto INT(10) NOT NULL,
  cantidad_producto SMALLINT(6) UNSIGNED NOT NULL CHECK (cantidad_producto > 0),
  precio_producto DECIMAL(10,2) UNSIGNED NOT NULL CHECK (precio_producto >= 0),
  id_pedido INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Tabla Valoraciones.
CREATE TABLE tb_valoraciones (
    id_valoracion INT PRIMARY KEY AUTO_INCREMENT,
    id_detalle INT NOT NULL,
    calificacion_producto INT CHECK (calificacion_producto BETWEEN 1 AND 5),
    comentario_producto VARCHAR(250),
    fecha_valoracion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_comentario BOOLEAN DEFAULT TRUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- Llaves Foraneas.

-- Llave foránea en la tabla tb_productos que referencia a tb_categorias.
ALTER TABLE tb_productos
ADD CONSTRAINT fk_categoria_producto 
FOREIGN KEY (id_categoria) 
REFERENCES tb_categorias(id_categoria);

-- Llave foránea en la tabla tb_pedidos que referencia a tb_clientes.
ALTER TABLE tb_pedidos
ADD CONSTRAINT fk_cliente_pedido 
FOREIGN KEY (id_cliente) 
REFERENCES tb_clientes(id_cliente);

-- Llave foránea en la tabla tb_detalles_pedidos que referencia a tb_productos.
ALTER TABLE tb_detalles_pedidos
ADD CONSTRAINT fk_producto_detalle 
FOREIGN KEY (id_producto) 
REFERENCES tb_productos(id_producto);

-- Llave foránea en la tabla tb_detalles_pedidos que referencia a tb_pedidos.
ALTER TABLE tb_detalles_pedidos
ADD CONSTRAINT fk_pedido_detalle 
FOREIGN KEY (id_pedido) 
REFERENCES tb_pedidos(id_pedido);

-- Llave foránea en la tabla tb_valoraciones que referencia a tb_detalles_pedidos.
ALTER TABLE tb_valoraciones
ADD CONSTRAINT fk_detalle_valoracion 
FOREIGN KEY (id_detalle) 
REFERENCES tb_detalles_pedidos(id_detalle);


-- Triggers

-- Metodo para cuando un cliente agregue un producto en el carrito disminuye el inventario.
DELIMITER $$

CREATE TRIGGER trg_disminuir_existencias
AFTER INSERT ON tb_detalles_pedidos
FOR EACH ROW
BEGIN
    UPDATE tb_productos 
    SET existencias_producto = existencias_producto - NEW.cantidad_producto
    WHERE id_producto = NEW.id_producto;
END$$

DELIMITER ;


-- Ingreso de datos para las tablas.

-- Datos de la tabla de Categorias.
INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria) VALUES ('Pasteles', 'Postres grandes en forma circular', 'Pastel.jfif');
INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria) VALUES ('Galletas', 'Galletas con cacao', 'Galletas.png');

-- Datos de la tabla de Productos.
INSERT INTO tb_productos (nombre_producto, descripcion_producto, precio_producto, existencias_producto, imagen_producto, id_categoria, estado_producto) 
VALUES ('Pastel de chocolate', 'Pastel de chocolate con frutas', 10.50, 100, 'Pastel_chocolate.jpg', 1, 1);
INSERT INTO tb_productos (nombre_producto, descripcion_producto, precio_producto, existencias_producto, imagen_producto, id_categoria, estado_producto) 
VALUES ('Pastel de vainilla', 'Pastel de vainilla con frutas', 9.50, 100, 'Pastel_vainilla.jpg', 1, 1);
INSERT INTO tb_productos (nombre_producto, descripcion_producto, precio_producto, existencias_producto, imagen_producto, id_categoria, estado_producto) 
VALUES ('Galletas simples', 'Galletas simples con azucar', 2.50, 100, 'Galletas_masa.jfif', 2, 1);
INSERT INTO tb_productos (nombre_producto, descripcion_producto, precio_producto, existencias_producto, imagen_producto, id_categoria, estado_producto) 
VALUES ('Galletas de chispas de chocolate', 'Galletas de chispas', 1.50, 100, 'Galletas_chispas.jpg', 2, 1);

-- Datos de la tabla de Clientes.
INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente, codigo_recuperacion, fecha_expiracion_codigo)
VALUES ('Sofía', 'Navas', '17719188-1', 'sofianavas2006@gmail.com', '77778891', 'San Salvador, Apopa', '2000-01-15', 'Elzapato_2001', '456987', '2024-12-31 23:59:59');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente, codigo_recuperacion, fecha_expiracion_codigo)
VALUES ('Miguel', 'Angel', '12222221-1', 'elmascapito@gmail.com', '71779988', 'San Salvador, Delgado', '2000-03-22', 'Elzapato_2002', '456989', '2024-12-31 23:59:59');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente, codigo_recuperacion, fecha_expiracion_codigo)
VALUES 
('Jose Alfredo', 'Ramiréz Ochoa', '13333331-1', 'elmasnegro2006@gmail.com', '72593434', 'San Salvador, Nejapa', '2000-07-10', 'Elzapato_2003', '451765', '2024-12-31 23:59:59');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente, codigo_recuperacion, fecha_expiracion_codigo)
VALUES 
('David', 'Gómez', '14444441-1', 'david.gomez@example.com', '72666666', 'San Salvador, San Salvador', '2000-12-05', 'Elzapato_2004', '265965', '2024-12-31 23:59:59');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente, codigo_recuperacion, fecha_expiracion_codigo)
VALUES 
('Lucía', 'Fernández', '15555551-1', 'lucia.fernandez@example.com', '79555555', 'San Salvador, Ilopango', '2000-04-30', 'Elzapato_2005', '200345', '2024-12-31 23:59:59');

-- Datos de la tabla de Pedidos.
INSERT INTO tb_pedidos (id_cliente, direccion_pedido, estado_pedido)
VALUES (1, 'San Salvador, Apopa', 'Pendiente');

INSERT INTO tb_pedidos (id_cliente, direccion_pedido, estado_pedido)
VALUES (2, 'San Salvador, Delgado', 'En camino');

INSERT INTO tb_pedidos (id_cliente, direccion_pedido, estado_pedido)
VALUES (3, 'San Salvador, Nejapa', 'Finalizado');

INSERT INTO tb_pedidos (id_cliente, direccion_pedido, estado_pedido)
VALUES (4, 'San Salvador, San Salvador', 'Pendiente');

INSERT INTO tb_pedidos (id_cliente, direccion_pedido, estado_pedido)
VALUES (5, 'San Salvador, Ilopango', 'En camino');

INSERT INTO tb_detalles_pedidos (id_producto, cantidad_producto, precio_producto, id_pedido)
VALUES 
(1, 5, 52.50, 1),
(2, 2, 19.00, 2),
(3, 3, 7.50, 3),
(4, 4, 6.00, 4),
(4, 3, 4.50, 5);

-- Insertar datos en la tabla tb_valoraciones
INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto)
VALUES 
(1, 5, 'Excelente pastel de chocolate muy cremoso.'),
(2, 4, 'El pastel de vanilla esta muy ricooo.'),
(3, 5, 'Las galletas son las mejores con su sabor.'),
(4, 3, 'Las galletas de chocolate esta bien.'),
(5, 5, 'Las mejores galletas que he probado.');

SELECT * FROM tb_categorias;
SELECT * FROM tb_productos;
SELECT * FROM tb_pedidos;
SELECT * FROM tb_clientes;
SELECT * FROM tb_detalles_pedidos;
SELECT * FROM tb_valoraciones;


