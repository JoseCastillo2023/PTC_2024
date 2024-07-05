<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../helpers/database.php');

/*
*   Clase para manejar el comportamiento de los datos de la tabla VALORACIONES.
*/
class ValoracionHandler
{
    /*
    *   Declaración de atributos para el manejo de datos.
    */
    protected $id = null;
    protected $search = null;
    protected $idDetalle = null;
    protected $calificacion = null;
    protected $comentario = null;
    protected $estado = null;

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
    */
    public function searchRows()
    {
        $this->search = $this->search === '' ? '%%' : '%' . $this->search . '%';

        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE CONCAT(c.nombre_cliente, " ", c.apellido_cliente) LIKE ? 
                OR p.nombre_producto LIKE ?
                ORDER BY v.fecha_valoracion DESC, v.estado_comentario DESC';

        $params = array($this->search, $this->search);
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_valoraciones(id_detalle, calificacion_producto, comentario_producto, fecha_valoracion, estado_comentario)
                VALUES(?, ?, ?, NOW(), true)';
        $params = array($this->idDetalle, $this->calificacion, $this->comentario);
        return Database::executeRow($sql, $params);
    }

    public function readAll()
    {
        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                ORDER BY v.fecha_valoracion DESC, v.estado_comentario DESC';
        return Database::getRows($sql);
    }

    public function readAllActive($value)
    {
        $value = $value === '' ? '%%' : '%' . $value . '%';
        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE v.estado_comentario = true
                AND (CONCAT(c.nombre_cliente, " ", c.apellido_cliente) LIKE ? OR v.comentario_producto LIKE ?)
                ORDER BY v.calificacion_producto DESC';
        $params = array($value, $value);
        return Database::getRows($sql, $params);
    }

    public function readByIdDetalle()
    {
        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE v.id_detalle = ?';
        $params = array($this->idDetalle);
        return Database::getRows($sql, $params);
    }

    public function readByIdValoracion()
    {
        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE v.id_valoracion = ?';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    public function readOne()
    {
        $sql = 'SELECT v.id_valoracion, v.id_detalle, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) as cliente, 
                       p.nombre_producto, v.calificacion_producto, v.comentario_producto, v.estado_comentario,
                       DATE_FORMAT(v.fecha_valoracion, "%d-%m-%Y - %h:%i %p") AS fecha_valoracion
                FROM tb_valoraciones v
                INNER JOIN tb_detallesOrdenes d ON v.id_detalle = d.id_detalle
                INNER JOIN tb_ordenes o ON d.id_orden = o.id_orden
                INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
                INNER JOIN tb_productos p ON d.id_producto = p.id_producto
                WHERE v.id_valoracion = ?
                ORDER BY v.fecha_valoracion DESC, v.estado_comentario DESC';
        $params = array($this->id);
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_valoraciones
                SET estado_comentario = ?
                WHERE id_valoracion = ?';
        $params = array($this->estado, $this->id);
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_valoraciones
                WHERE id_valoracion = ?';
        $params = array($this->id);
        return Database::executeRow($sql, $params);
    }
}
?>