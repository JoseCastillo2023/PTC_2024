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


-- Llaves foráneas

ALTER TABLE tb_detalles_ordenes
ADD CONSTRAINT fk_detalle_orden FOREIGN KEY (id_orden) REFERENCES tb_ordenes(id_orden);

ALTER TABLE tb_detalles_ordenes
ADD CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES tb_productos(id_producto);

ALTER TABLE tb_productos
ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES tb_categorias(id_categoria);

ALTER TABLE tb_valoraciones
ADD CONSTRAINT fk_valoracion_detalle FOREIGN KEY (id_detalle) REFERENCES tb_detalles_ordenes(id_detalle);

ALTER TABLE tb_ordenes
ADD CONSTRAINT fk_orden_cliente FOREIGN KEY (id_cliente) REFERENCES tb_clientes(id_cliente);


SELECT * FROM tb_clientes; SELECT * FROM tb_detalles_ordenes; SELECT * FROM tb_ordenes; SELECT * FROM tb_productos; SELECT * FROM tb_categorias; SELECT * FROM tb_administradores;
SELECT * FROM tb_valoraciones;


INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, nacimiento_cliente, clave_cliente)
VALUES
('María', 'López', '111222333', 'maria.lopez@example.com', '777111222', 'Calle Principal #123', '1990-07-15', 'clave123'),
('Carlos', 'Gómez', '444555666', 'carlos.gomez@example.com', '777444555', 'Avenida Central #456', '1985-05-20', 'contrasena456'),
('Ana', 'Martínez', '777888999', 'ana.martinez@example.com', '777777888', 'Calle Secundaria #789', '1998-12-10', 'pwd789'),
('Pedro', 'Hernández', '222333444', 'pedro.hernandez@example.com', '777222333', 'Boulevard Principal #987', '1992-04-03', 'secreto987'),
('Luisa', 'García', '555666777', 'luisa.garcia@example.com', '777555666', 'Plaza Mayor #321', '1987-11-25', 'clave321');


INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES
('Electrónicos', 'Productos electrónicos de última generación', 'electronica.jpg'),
('Ropa', 'Ropa de moda para todas las edades', 'ropa.jpg'),
('Libros', 'Libros de diversos géneros literarios', 'libros.jpg'),
('Hogar', 'Artículos para el hogar y decoración', 'hogar.jpg'),
('Deportes', 'Equipos y accesorios deportivos', 'deportes.jpg');

INSERT INTO tb_productos (nombre_producto, descripcion_producto, precio_producto, existencias_producto, imagen_producto, id_categoria, estado_producto, id_administrador)
VALUES
('Smartphone', 'Teléfono inteligente de última generación', 799.99, 100, 'smartphone.jpg', 1, 1, 1),
('Camiseta', 'Camiseta de algodón unisex', 29.99, 200, 'camiseta.jpg', 2, 1, 1),
('El Hobbit', 'Novela de fantasía escrita por J.R.R. Tolkien', 15.50, 150, 'hobbit.jpg', 3, 1, 1),
('Juego de Sábanas', 'Sábanas de algodón para cama king size', 49.99, 50, 'sabanas.jpg', 4, 1, 1),
('Balón de Fútbol', 'Balón oficial de fútbol tamaño 5', 19.99, 100, 'balon.jpg', 5, 1, 1);

INSERT INTO tb_ordenes (id_cliente, forma_pago_pedido, estado_pedido)
VALUES
(1, 'Efectivo', 'Finalizado'),
(2, 'Transferencia', 'Pendiente'),
(3, 'Efectivo', 'Finalizado'),
(4, 'Efectivo', 'Anulado'),
(5, 'Transferencia', 'Pendiente');


INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto)
VALUES
(1, 1, 2),
(1, 2, 3),
(2, 3, 1),
(3, 4, 2),
(4, 5, 1);

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto)
VALUES
(1, 5, 'Excelente producto, estoy muy contento con mi compra.'),
(2, 4, 'Buena calidad, pero el envío fue un poco lento.'),
(3, 3, 'El libro es interesante, pero esperaba más del final.'),
(4, 5, 'Las sábanas son muy suaves y confortables.'),
(5, 4, 'El balón tiene buen agarre y resistencia, recomendado para jugar en césped.');	