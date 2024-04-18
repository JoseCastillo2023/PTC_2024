USE use PanaderiaHPTC;

-- insert de datos 

-- clientes
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


-- Productos

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
VALUES (1, 101, 'Pan Dulce', 'Delicioso pan dulce recién horneado.', 3.50, 'pan_dulce.jpg'); 

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(1, 101, 'Rosca de Reyes', 'Tradicional rosca de reyes decorada con frutas cristalizadas.', 12.99, 'rosca_reyes.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(2, 102, 'Pastel de Chocolate', 'Esponjoso pastel de chocolate cubierto con ganache.', 18.50, 'pastel_chocolate.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(2, 102, 'Pastel de Fresa', 'Pastel suave de fresa con crema chantilly y relleno de fresas frescas.', 20.00, 'pastel_fresa.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(3, 103, 'Galletas de Mantequilla', 'Galletas caseras de mantequilla con textura crujiente.', 5.99, 'galletas_mantequilla.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(3, 103, 'Galletas de Chocolate Chip', 'Galletas clásicas con chispas de chocolate.', 6.50, 'galletas_chocolate_chip.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(4, 104, 'Pan de Nuez', 'Pan rústico con trozos de nuez, perfecto para acompañar el café.', 4.75, 'pan_nuez.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(4, 104, 'Pan Multigrano', 'Pan elaborado con una mezcla de granos y semillas, saludable y delicioso.', 5.25, 'pan_multigrano.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(5, 105, 'Croissants', 'Croissants recién horneados, crujientes por fuera y suaves por dentro.', 2.99, 'croissants.jpg');

INSERT INTO tb_productos (id_categoria, id_administrador, nombre_producto, descripcion_producto, precio_producto, imagen_producto) 
(5, 105, 'Pretzels', 'Pretzels tradicionales salados, ideales para un snack rápido.', 1.75, 'pretzels.jpg');


--  Categorias 
INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria) 
VALUES ('Pan dulce', 'Variedad de panes dulces ideales para el desayuno o la merienda.', 'pan_dulce.jpg');

INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES ('Pasteles', 'Deliciosos pasteles para celebraciones especiales o simplemente para disfrutar.', 'pasteles.jpg');

INSERT INTO tb_categorias (nombre_categoria, descripcion_categoria, imagen_categoria)
VALUES ('Bollería', 'Una selección de productos de bollería fresca y deliciosa.', 'bolleria.jpg');

-- Administrador 

INSERT INTO tb_administradores (id_administrador, nombre_admistrador, apellido_administrador, correo_administrador, alias_administrador, clave_administrador)
VALUES ('1', 'Juan', 'Hernandez' , 'Hernandez@gmail.com', 'Hernanzg45', 'Hernandez345');


-- Valoraciones 

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
VALUES (1, 5, 'El pan dulce estaba delicioso, definitivamente volveré por más.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(2, 4, 'Los pasteles estaban frescos y con buen sabor, aunque podrían mejorar la presentación.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(3, 3, 'El pan integral estaba un poco seco, pero el sabor era aceptable.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(4, 5, '¡Los croissants son increíbles! Simplemente deliciosos.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(5, 4, 'El pastel de zanahoria es mi favorito, siempre es una excelente elección.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(6, 2, 'La baguette estaba demasiado dura para mi gusto, esperaba algo más fresco.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(7, 5, 'La tarta de manzana es espectacular, la recomiendo totalmente.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(8, 4, 'Los bollos de canela son una delicia, siempre los compro para el desayuno.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(9, 3, 'El pan de centeno estaba bien, pero creo que le faltaba un poco de sal.', 'Habilitado');

INSERT INTO tb_valoraciones (id_detalle, calificacion_producto, comentario_producto, estado_comentario)
(10, 5, '¡Los donuts son adictivos! Siempre me llevo varios cuando visito la panadería.', 'Habilitado');
