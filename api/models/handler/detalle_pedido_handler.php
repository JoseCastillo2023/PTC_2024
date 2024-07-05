<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../helpers/database.php');

/*
*	Clase para manejar el comportamiento de los datos de la tabla DETALLES ORDENES.
*/
class DetallePedidoHandler
{
    /*
    *   Declaración de atributos para el manejo de datos.
    */
    protected $id = null;
    protected $search = null;
    protected $id_orden = null;
    protected $id_producto = null;
    protected $cantidad_producto = null;

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
    */
    public function searchRows()
    {
        $this->search = $this->search === '' ? '%%' : '%' . $this->search . '%';

        $sql = 'SELECT d.id_detalle, o.id_orden, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) AS cliente,
                       p.nombre_producto, d.cantidad_producto, o.fecha_pedido, o.estado_pedido
                FROM tb_detalles_ordenes d
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                WHERE o.id_orden = ? AND (p.nombre_producto LIKE ? OR o.estado_pedido LIKE ?)
                ORDER BY p.nombre_producto';

        $params = array($this->id_orden, $this->search, $this->search);
        return Database::getRows($sql, $params);
    }

    public function searchHistorial()
    {
        $sql = 'SELECT d.id_detalle, o.id_orden, p.nombre_producto, p.descripcion_producto,
                       d.cantidad_producto, o.fecha_pedido, p.imagen_producto, 
                       ROUND(p.precio_producto * d.cantidad_producto, 2) AS subtotal
                FROM tb_detalles_ordenes d
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE o.id_orden = ?
                ORDER BY p.nombre_producto';

        $params = array($this->id_orden);
        return Database::getRows($sql, $params);
    }

    public function searchHistorial2()
    {
        $sql = 'SELECT d.id_detalle, o.id_orden, p.nombre_producto, p.descripcion_producto,
                       d.cantidad_producto, o.fecha_pedido, p.imagen_producto, 
                       ROUND(p.precio_producto * d.cantidad_producto, 2) AS subtotal
                FROM tb_detalles_ordenes d
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE o.estado_pedido = "Finalizado"
                ORDER BY p.nombre_producto';

        $params = array();
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_detalles_ordenes(id_orden, id_producto, cantidad_producto)
                VALUES(?, ?, ?)';
        $params = array($this->id_orden, $this->id_producto, $this->cantidad_producto);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT d.id_detalle, d.id_orden, d.id_producto, d.cantidad_producto, p.nombre_producto
                FROM tb_detalles_ordenes d
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE d.id_orden = ?
                ORDER BY p.nombre_producto';
        
        $params = array($this->id_orden);
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT d.id_detalle, d.id_orden, d.id_producto, d.cantidad_producto, p.nombre_producto
                FROM tb_detalles_ordenes d
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE d.id_detalle = ?';
        
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_detalles_ordenes
                SET id_producto = ?, cantidad_producto = ?
                WHERE id_detalle = ?';
        $params = array($this->id_producto, $this->cantidad_producto, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_detalles_ordenes
                WHERE id_detalle = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }

    /*
    *   Métodos para generar gráficos.
    */
    public function cantidadProductosCategoria()
    {
        $sql = 'SELECT c.nombre_categoria, COUNT(p.id_producto) cantidad
                FROM tb_productos p
                INNER JOIN tb_categorias c ON p.id_categoria = c.id_categoria
                GROUP BY c.nombre_categoria ORDER BY cantidad DESC LIMIT 5';
        return Database::getRows($sql);
    }

    public function porcentajeProductosCategoria()
    {
        $sql = 'SELECT c.nombre_categoria, 
                       ROUND((COUNT(p.id_producto) * 100.0 / (SELECT COUNT(id_producto) FROM tb_productos)), 2) porcentaje
                FROM tb_productos p
                INNER JOIN tb_categorias c ON p.id_categoria = c.id_categoria
                GROUP BY c.nombre_categoria ORDER BY porcentaje DESC';
        return Database::getRows($sql);
    }
}
?>
