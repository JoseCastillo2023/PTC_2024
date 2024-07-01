-- eliminacion base de datos
-- DROP DATABASE PanaderiaHPTC;

-- creacion base de datos 
create database PanaderiaHPTC;

use PanaderiaHPTC;

-- Tablas
CREATE TABLE tb_clientes(
id_cliente INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre_cliente VARCHAR(25) NOT NULL,
apellido_cliente VARCHAR(25) NOT NULL,
dui_cliente VARCHAR(10) UNIQUE NOT NULL,
correo_cliente VARCHAR(125) NOT NULL,
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

create table tb_detallesOrdenes(
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

CREATE TABLE tb_administradores(
id_administrador int not null primary KEY AUTO_INCREMENT,
nombre_administrador varchar(50) NOT NULL,
apellido_administrador varchar(50) not null,
correo_administrador varchar(100) not null,
alias_administrador VARCHAR(25) UNIQUE not null,
clave_administrador varchar(100) not NULL
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

alter table tb_detallesOrdenes add constraint fk_orden_detalle foreign key(id_orden) references tb_ordenes(id_orden);
alter table tb_detallesOrdenes add constraint fk_orden_productos foreign key (id_producto) references tb_productos(id_producto);

alter table tb_valoraciones add constraint fk_orden_valoracion foreign key (id_detalle) references tb_detallesOrdenes(id_detalle);


-- Constaint

ALTER TABLE tb_clientes ADD CONSTRAINT unique_dui UNIQUE (dui_cliente);
ALTER TABLE tb_clientes ADD CONSTRAINT unique_telefono UNIQUE (telefono_cliente);
ALTER TABLE tb_administradores ADD CONSTRAINT unique_alias UNIQUE (alias_administrador);



-- Selects de las tablas 

-- SELECT * FROM tb_clientes;

-- SELECT * FROM tb_ordenes;

-- SELECT * FROM tb_detallesOrdenes;

-- SELECT * FROM tb_categorias;

-- SELECT * FROM tb_productos;