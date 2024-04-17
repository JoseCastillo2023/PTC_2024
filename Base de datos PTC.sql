-- eliminacion base de datos
-- DROP DATABASE PanaderiaHPTC;

-- creacion base de datos 
DROP DATABASE IF EXISTS PanaderiaHPTC;
CREATE DATABASE PanaderiaHPTC;

USE PanaderiaHPTC;

-- Tablas
CREATE TABLE tb_clientes(
id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre_cliente VARCHAR(25) NOT NULL,
apellido_cliente VARCHAR(25) NOT NULL,
dui_cliente VARCHAR(10) UNIQUE NOT NULL,
correo_cliente VARCHAR(125) UNIQUE NOT NULL,
telefono_cliente VARCHAR(10) UNIQUE NOT NULL,
direccion_cliente VARCHAR(200) NOT NULL,
clave_cliente VARCHAR(150) NOT NULL,
estado_cliente enum("Activo", "Inactivo") NOT NULL DEFAULT("Inactivo")
);

CREATE TABLE tb_ordenes(
id_orden int not null primary key AUTO_INCREMENT,
id_cliente int not null,
estado_orden enum("Entregada", "Anulada", "Finalizada", "Pendiente") not null,
fecha_orden DATE not null default NOW(),
direccion_orden VARCHAR(200) NOT NULL
);

create table tb_detalles_ordenes(
id_detalle int not null primary key auto_increment,
id_orden int not null,
id_producto int not null,
cantidad_producto int check(cantidad_producto > 0),
total_a_pagar decimal(5,2) not null check(total_a_pagar > 0)
);

CREATE TABLE tb_categorias(
id_categoria int not null primary key AUTO_INCREMENT,
nombre_categoria VARCHAR(25) not null,
descripcion_categoria VARCHAR(150) not null,
imagen_categoria VARCHAR(250) not null
);

CREATE TABLE tb_productos(
id_producto int not null primary key AUTO_INCREMENT,
id_categoria int not NULL,
id_administrador INT NOT NULL, 
nombre_producto varchar(50) not null,
descripcion_producto varchar(250) not null,
precio_producto numeric(8,2) not null check(precio_producto > 0),
imagen_producto varchar(100) not NULL
);

CREATE TABLE tb_tipos_administradores(
id_tipo int not null primary KEY AUTO_INCREMENT,
nombre_tipo varchar(50) not null
);

CREATE TABLE tb_administradores(
id_administrador int not null primary KEY AUTO_INCREMENT,
nombre_admistrador  varchar(50) not null,
apellido_administrador varchar(50) not null,
correo_administrador varchar(100) UNIQUE not null,
alias_administrador VARCHAR(25) UNIQUE not null,
clave_administrador varchar(100) not NULL,
id_tipo int not null
);

create table tb_valoraciones(
id_valoracion int not null primary key auto_increment,
id_detalle int not null,
calificacion_producto int null,
comentario_producto varchar(250) null,
fecha_valoracion date not null default NOW(),
estado_comentario enum("Habilitado", "Deshabilitado") not null
);


-- Foreing keys

alter table tb_ordenes add constraint fk_orden_cliente foreign key(id_cliente) references tb_clientes(id_cliente);

alter table tb_productos add constraint fk_producto_admin foreign key(id_administrador) references tb_administradores(id_administrador);
alter table tb_productos add constraint fk_producto_categoria foreign key(id_categoria) references tb_categorias(id_categoria);

alter table tb_detalles_ordenes add constraint fk_orden_detalle foreign key(id_orden) references tb_ordenes(id_orden);
alter table tb_detalles_ordenes add constraint fk_orden_productos foreign key (id_producto) references tb_productos(id_producto);

alter table tb_valoraciones add constraint fk_orden_valoracion foreign key (id_detalle) references tb_detalles_ordenes(id_detalle);

alter table tb_administradores add constraint fk_tipo_administradores foreign key (id_tipo) references tb_tipos_administradores(id_tipo);


-- Insercción de datos.

-- Tipo Administradores.
INSERT INTO tb_tipos_administradores (id_tipo, nombre_tipo) VALUES ('1', 'Administrador');
INSERT INTO tb_tipos_administradores (id_tipo, nombre_tipo) VALUES ('2', 'Empleado');


-- Administradores.
INSERT INTO tb_administradores (id_administrador, nombre_admistrador, apellido_administrador, correo_administrador, alias_administrador, clave_administrador, id_tipo)
VALUES ('1', 'Juan', 'Hernandez' , 'Hernandez@gmail.com', 'Hernanzg45', 'Hernandez345', 1);

INSERT INTO tb_administradores (id_administrador, nombre_admistrador, apellido_administrador, correo_administrador, alias_administrador, clave_administrador, id_tipo)
VALUES ('2', 'Jose', 'Castillo' , 'jusepecastillo@gmail.com', 'JosepKast', 'Josep0002024', 2);

-- Clientes.
INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Juan', 'Martínez', '001234567-8', 'juan@example.com', '70123456', 'Calle Principal #123', 'clave123', 'Activo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('María', 'González', '012345678-9', 'maria@example.com', '71234567', 'Avenida Central #456', 'clave456', 'Activo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Pedro', 'Hernández', '023456789-0', 'pedro@example.com', '72345678', 'Calle Secundaria #789', 'clave789', 'Inactivo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Ana', 'López', '034567890-1', 'ana@example.com', '73456789', 'Boulevard Este #1011', 'clave1011', 'Activo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Carlos', 'Pérez', '045678901-2', 'carlos@example.com', '74567890', 'Pasaje Oeste #1213', 'clave1213', 'Inactivo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Laura', 'Díaz', '056789012-3', 'laura@example.com', '75678901', 'Callejón Norte #1415', 'clave1415', 'Activo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Luis', 'Rodríguez', '067890123-4', 'luis@example.com', '76789012', 'Avenida Sur #1617', 'clave1617', 'Inactivo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Sofía', 'Sánchez', '078901234-5', 'sofia@example.com', '77890123', 'Camino Real #1819', 'clave1819', 'Activo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Daniel', 'Gómez', '089012345-6', 'daniel@example.com', '78901234', 'Calle Principal #2021', 'clave2021', 'Inactivo');

INSERT INTO tb_clientes (nombre_cliente, apellido_cliente, dui_cliente, correo_cliente, telefono_cliente, direccion_cliente, clave_cliente, estado_cliente) 
VALUES ('Elena', 'Torres', '090123456-7', 'elena@example.com', '79012345', 'Boulevard Central #2223', 'clave2223', 'Activo');


--  Categorias 
INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria) 
VALUES ('Pan dulce', 'Variedad de panes dulces ideales para el desayuno o la merienda.', 'pan_dulce.jpg');

INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES ('Pasteles', 'Deliciosos pasteles para celebraciones especiales o simplemente para disfrutar.', 'pasteles.jpg');

INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES ('Bollería', 'Una selección de productos de bollería fresca y deliciosa.', 'bolleria.jpg');

-- Productos.
INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 1, 'Pan Dulce', 'Delicioso pan dulce recién horneado.', 3.50, 'pan_dulce.jpg'); 

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 1, 'Rosca de Reyes', 'Tradicional rosca de reyes decorada con frutas cristalizadas.', 12.99, 'rosca_reyes.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (2, 1, 'Pastel de Chocolate', 'Esponjoso pastel de chocolate cubierto con ganache.', 18.50, 'pastel_chocolate.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (2, 1, 'Pastel de Fresa', 'Pastel suave de fresa con crema chantilly y relleno de fresas frescas.', 20.00, 'pastel_fresa.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (3, 2, 'Galletas de Mantequilla', 'Galletas caseras de mantequilla con textura crujiente.', 5.99, 'galletas_mantequilla.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (3, 2, 'Galletas de Chocolate Chip', 'Galletas clásicas con chispas de chocolate.', 6.50, 'galletas_chocolate_chip.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 2, 'Pan de Nuez', 'Pan rústico con trozos de nuez, perfecto para acompañar el café.', 4.75, 'pan_nuez.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 2, 'Pan Multigrano', 'Pan elaborado con una mezcla de granos y semillas, saludable y delicioso.', 5.25, 'pan_multigrano.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 2, 'Croissants', 'Croissants recién horneados, crujientes por fuera y suaves por dentro.', 2.99, 'croissants.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 2, 'Pretzels', 'Pretzels tradicionales salados, ideales para un snack rápido.', 1.75, 'pretzels.jpg');


-- Ordenes.
INSERT INTO tb_ordenes (id_cliente, estado_orden, direccion_orden) VALUES (1, 'Entregada', 'San Salvador, San Salvador');
INSERT INTO tb_ordenes (id_cliente, estado_orden, direccion_orden) VALUES (2, 'Entregada', 'Apopa, San Salvador');


-- Detalles Ordenes.
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (1, 1, 2, '12.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (1, 2, 3, '15.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (1, 3, 4, '20.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (1, 4, 5, '26.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (1, 5, 1, '5.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (2, 6, 10, '55.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (2, 7, 8, '44.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (2, 8, 7, '29.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (2, 9, 3, '18.00');
INSERT INTO tb_detalles_ordenes (id_orden, id_producto, cantidad_producto, total_a_pagar) VALUES (2, 10, 2, '9.00');


-- Valoraciones.
INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (1, 5, 'El pan dulce estaba delicioso, definitivamente volveré por más.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (2, 4, 'Los pasteles estaban frescos y con buen sabor, aunque podrían mejorar la presentación.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (3, 3, 'El pan integral estaba un poco seco, pero el sabor era aceptable.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (4, 5, '¡Los croissants son increíbles! Simplemente deliciosos.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (5, 4, 'El pastel de zanahoria es mi favorito, siempre es una excelente elección.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (6, 2, 'La baguette estaba demasiado dura para mi gusto, esperaba algo más fresco.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (7, 5, 'La tarta de manzana es espectacular, la recomiendo totalmente.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (8, 4, 'Los bollos de canela son una delicia, siempre los compro para el desayuno.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (9, 3, 'El pan de centeno estaba bien, pero creo que le faltaba un poco de sal.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (10, 5, '¡Los donuts son adictivos! Siempre me llevo varios cuando visito la panadería.', 'Habilitado');



-- Selects de las tablas 

SELECT * FROM tb_tipos_administradores;
SELECT * FROM tb_administradores;
SELECT * FROM tb_clientes;
SELECT * FROM tb_ordenes;
SELECT * FROM tb_detalles_ordenes;
SELECT * FROM tb_categorias;
SELECT * FROM tb_productos;
SELECT * FROM tb_valoraciones


-- Funciones

DELIMITER //

CREATE FUNCTION calcular_total_producto(producto_id INT, cantidad INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE precio_del_producto DECIMAL(10, 2);
    DECLARE total DECIMAL(10, 2);
    
    -- Obtener el precio del producto
    SELECT precio_producto INTO precio_del_producto
    FROM tb_productos
    WHERE id_producto = producto_id;
    
    -- Calcular el total
    SET total = precio_del_producto * cantidad;
    
    RETURN total;
END

//
DELIMITER ;

