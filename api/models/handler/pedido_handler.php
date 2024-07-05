<?php
// Se incluye la clase para trabajar con la base de datos.
require_once('../../helpers/database.php');
/*
*	Clase para manejar el comportamiento de los datos de las tablas ORDENES y DETALLES_ORDENES.
*/
class PedidoHandler
{
    /*
    *   Declaración de atributos para el manejo de datos.
    */
    protected $search = null;
    protected $id = null;
    protected $nombre = null;
    protected $descripcion = null;
    protected $precio = null;
    protected $existencias = null;
    protected $imagen = null;
    protected $categoria = null;
    protected $estado = null;

    protected $id_orden = null;
    protected $id_producto = null;
    protected $id_detalle = null;
    protected $cliente = null;
    protected $producto = null;
    protected $cantidad = null;

    /*
    *   Métodos para realizar las operaciones SCRUD (search, create, read, update, and delete).
    */
    public function searchByCliente()
    {
        $sql = 'SELECT id_orden, CONCAT(nombre_cliente, " ", apellido_cliente) as cliente,
        id_cliente, correo_cliente,DATE_FORMAT(fecha_pedido, "%h:%i %p - %e %b %Y") AS fecha, estado_pedido,forma_pago_pedido
        FROM tb_ordenes INNER JOIN tb_clientes USING(id_cliente)
        WHERE estado_pedido = ? AND id_cliente = ?';

        $params = [$this->estado, $_SESSION['idCliente']];
        switch ($this->search) {
            case '3meses':
                $interval = 90; // Aproximadamente 3 meses
                break;
            case '1mes':
                $interval = 30; // Aproximadamente 1 mes
                break;
            case '7dias':
                $interval = 7; // 7 días
                break;
            default:
                $interval = null; // 'Todo' u otro valor no requiere filtro adicional
        }
        if ($interval) {
            $sql .= ' AND fecha_pedido >= DATE_SUB(CURDATE(), INTERVAL ? DAY)';
            $params[] = $interval;
        }
        $sql .= ' ORDER BY fecha_pedido DESC';
        return Database::getRows($sql, $params);
    }
    
    public function getOrder()
    {
        $this->estado = 'Pendiente';
        $sql = 'SELECT id_orden FROM tb_ordenes
         WHERE estado_pedido = ? AND id_cliente = ?';

        $params = array($this->estado, $_SESSION['idCliente']);
        if ($data = Database::getRow($sql, $params)) {
            $_SESSION['idOrden'] = $data['id_orden'];
            return true;
        } else {
            return false;
        }
    }

    // Método para iniciar un pedido en proceso.
    public function startOrder()
    {
        if ($this->getOrder()) {
            return true;
        } else {
            $sql = 'INSERT INTO tb_ordenes(id_cliente,forma_pago_pedido,fecha_pedido,estado_pedido)
                    VALUES(?,?,now(),"Pendiente")';
            $params = array($_SESSION['idCliente'], "Efectivo");
            // Se obtiene el ultimo valor insertado de la llave primaria en la tabla orden.
            if ($_SESSION['idOrden'] = Database::getLastRow($sql, $params)) {
                return true;
            } else {
                return false;
            }
        }
    }

    // Método para agregar un producto al carrito de compras.
    public function createDetail()
    {
        $sql = 'SELECT * FROM tb_detalles_ordenes
        WHERE id_orden=? AND id_producto=?;';
        $params = array($_SESSION['idOrden'], $this->id_producto);
        $result = Database::getRow($sql, $params);
        $mensaje = null;

        if ($result) {
            $this->cantidad = $this->cantidad + $result['cantidad_producto'];
            if ($this->cantidad < 4) {
                $sql = 'UPDATE tb_detalles_ordenes 
                SET cantidad_producto= ? WHERE id_detalle=?';
                $params = array($this->cantidad, $result['id_detalle']);
                if (Database::executeRow($sql, $params)) {
                    $mensaje = 1;
                }
            } else {
                $mensaje = 2;
            }
        } else {
            $sql = 'INSERT INTO tb_detalles_ordenes(id_producto, cantidad_producto, id_orden)
                VALUES(?, ?, ?)';
            $params = array($this->id_producto, $this->cantidad, $_SESSION['idOrden']);
            if (Database::executeRow($sql, $params)) {
                $mensaje = 1;
            }
        }
        return $mensaje;
    }

    // Método para obtener los productos que se encuentran en el carrito de compras.
    public function readDetail()
    {
        $sql = 'SELECT id_detalle, id_producto, nombre_producto, descripcion_producto, precio_producto, cantidad_producto
                FROM tb_detalles_ordenes
                INNER JOIN tb_productos USING(id_producto)
                WHERE id_orden = ?';
        $params = array($_SESSION['idOrden']);
        return Database::getRows($sql, $params);
    }

    public function getOrderM()
    {
        $this->estado = 'Pendiente';
        $sql = 'SELECT id_orden FROM tb_ordenes
            WHERE estado_pedido = ? AND id_cliente = ?';

        $params = array($this->estado, $this->cliente);
        $data = Database::getRow($sql, $params);

        if ($data) {
            return $data['id_orden'];
        } else {
            return null;
        }
    }

    public function startOrderM()
    {
        if ($this->getOrderM()) {
            return true;
        } else {
            $sql = 'INSERT INTO tb_ordenes(id_cliente, forma_pago_pedido, fecha_pedido, estado_pedido)
                VALUES (?, ?, now(), "Pendiente")';
            $params = array($this->cliente, "Efectivo");

            if ($idOrden = Database::getLastRow($sql, $params)) {
                return $idOrden;
            } else {
                return null;
            }
        }
    }

    public function createDetailM()
    {
        $clientId = $this->cliente;
        $idProducto = $this->id_producto;
        $cantidadProducto = $this->cantidad;

        $idOrden = $this->getOrderM($clientId);
        $mensaje = null;

        if ($idOrden) {
            $sql = 'SELECT * FROM tb_detalles_ordenes
                WHERE id_orden = ? AND id_producto = ?';
            $params = array($idOrden, $idProducto);
            $result = Database::getRow($sql, $params);

            if ($result) {
                $cantidad = $cantidadProducto + $result['cantidad_producto'];
                if ($cantidad < 4) {
                    $sql = 'UPDATE tb_detalles_ordenes 
                        SET cantidad_producto = ? WHERE id_detalle = ?';
                    $params = array($cantidad, $result['id_detalle']);
                    if (Database::executeRow($sql, $params)) {
                        $mensaje = array('status' => 1, 'idOrden' => $idOrden);
                    }
                } else {
                    $mensaje = array('status' => 2);
                }
            } else {
                $sql = 'INSERT INTO tb_detalles_ordenes(id_producto, cantidad_producto, id_orden)
                    VALUES (?, ?, ?)';
                $params = array($idProducto, $cantidadProducto, $idOrden);
                if (Database::executeRow($sql, $params)) {
                    $mensaje = array('status' => 1, 'idOrden' => $idOrden);
                }
            }
        }

        return $mensaje;
    }

    // Método para finalizar un pedido por parte del cliente.
    public function finishOrder()
    {
        $this->estado = 'Finalizado';
        $sql = 'UPDATE tb_ordenes
                SET estado_pedido = ?
                WHERE id_orden = ?';
        $params = array($this->estado, $_SESSION['idOrden']);
        return Database::executeRow($sql, $params);
    }

    // Método para actualizar la cantidad de un producto agregado al carrito de compras.
    public function updateDetail()
    {
        $sql = 'UPDATE tb_detalles_ordenes
                SET cantidad_producto = ?
                WHERE id_detalle = ? AND id_orden = ?';
        $params = array($this->cantidad, $this->id_detalle, $_SESSION['idOrden']);
        return Database::executeRow($sql, $params);
    }

    // Método para eliminar un producto que se encuentra en el carrito de compras.
    public function deleteDetail()
    {
        $sql = 'DELETE FROM tb_detalles_ordenes
                WHERE id_detalle = ? AND id_orden = ?';
        $params = array($this->id_detalle, $_SESSION['idOrden']);
        return Database::executeRow($sql, $params);
    }

    public function searchRows()
    {
        $this->search = $this->search === '' ? '%%' : '%' . $this->search . '%';

        $sql = 'SELECT o.id_orden, c.id_cliente, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) AS cliente,
        o.fecha_pedido, o.estado_pedido, o.forma_pago_pedido, o.fecha_entregado, 
        GROUP_CONCAT(CONCAT(p.nombre_producto, " - ", d.cantidad_producto) SEPARATOR ", ") AS productos
        FROM tb_ordenes o
        INNER JOIN tb_detalles_ordenes d ON o.id_orden = d.id_orden
        INNER JOIN tb_productos p ON d.id_producto = p.id_producto
        INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
        WHERE c.nombre_cliente LIKE ? OR c.apellido_cliente LIKE ? OR p.nombre_producto LIKE ? OR o.estado_pedido LIKE ?
        GROUP BY o.id_orden, c.id_cliente, c.nombre_cliente, c.apellido_cliente, o.fecha_pedido, o.estado_pedido, o.forma_pago_pedido, o.fecha_entregado';
        
        $params = [$this->search, $this->search, $this->search, $this->search];
        return Database::getRows($sql, $params);
    }

    public function createRow()
    {
        $sql = 'INSERT INTO tb_ordenes(id_cliente, forma_pago_pedido, fecha_pedido, estado_pedido)
                VALUES(?, ?, ?, ?)';
        $params = [$this->id_cliente, $this->forma_pago_pedido, $this->fecha_pedido, $this->estado];
        return Database::executeRow($sql, $params);
    }

    public function readRow()
    {
        $sql = 'SELECT o.id_orden, o.id_cliente, CONCAT(c.nombre_cliente, " ", c.apellido_cliente) AS cliente,
        o.fecha_pedido, o.estado_pedido, o.forma_pago_pedido, o.fecha_entregado,
        GROUP_CONCAT(CONCAT(p.nombre_producto, " - ", d.cantidad_producto) SEPARATOR ", ") AS productos
        FROM tb_ordenes o
        INNER JOIN tb_detalles_ordenes d ON o.id_orden = d.id_orden
        INNER JOIN tb_productos p ON d.id_producto = p.id_producto
        INNER JOIN tb_clientes c ON o.id_cliente = c.id_cliente
        WHERE o.id_orden = ?
        GROUP BY o.id_orden, o.id_cliente, c.nombre_cliente, c.apellido_cliente, o.fecha_pedido, o.estado_pedido, o.forma_pago_pedido, o.fecha_entregado';

        $params = [$this->id];
        return Database::getRow($sql, $params);
    }

    public function updateRow()
    {
        $sql = 'UPDATE tb_ordenes
                SET estado_pedido = ?, forma_pago_pedido = ?, fecha_entregado = ?
                WHERE id_orden = ?';
        $params = [$this->estado_pedido, $this->forma_pago_pedido, $this->fecha_entregado, $this->id];
        return Database::executeRow($sql, $params);
    }

    public function deleteRow()
    {
        $sql = 'DELETE FROM tb_ordenes
                WHERE id_orden = ?';
        $params = [$this->id];
        return Database::executeRow($sql, $params);
    }

    /*
    *   Métodos para manejar las relaciones de muchos a muchos con la tabla CATEGORÍAS.
    */

    // Método para leer todas las categorías de un producto en particular.
    public function readCategories()
    {
        $sql = 'SELECT id_categoria, nombre_categoria
                FROM categorias
                INNER JOIN categorias_productos USING(id_categoria)
                WHERE id_producto = ?';
        $params = array($this->id);
        return Database::getRows($sql, $params);
    }

    // Método para agregar una categoría a un producto.
    public function addCategory()
    {
        $sql = 'INSERT INTO categorias_productos(id_categoria, id_producto)
                VALUES(?, ?)';
        $params = array($this->categoria, $this->id);
        return Database::executeRow($sql, $params);
    }

    // Método para eliminar una categoría de un producto.
    public function deleteCategory()
    {
        $sql = 'DELETE FROM categorias_productos
                WHERE id_categoria = ? AND id_producto = ?';
        $params = array($this->categoria, $this->id);
        return Database::executeRow($sql, $params);
    }

    // Método para leer todas las categorías disponibles.
    public function readAllCategories()
    {
        $sql = 'SELECT id_categoria, nombre_categoria
                FROM categorias';
        $params = array(null);
        return Database::getRows($sql, $params);
    }
}