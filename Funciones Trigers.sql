USE ejercicio_propuesto;

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