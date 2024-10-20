<?php
// Incluir archivos necesarios
require_once ('../../helpers/comprobante.php');
require_once ('../../models/data/pedido_data.php');
require_once ('../../models/data/producto_data.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;
$pdf->startReport('Comprobante de compra');

// Se instancia el modelo Pedido para obtener los datos.
$pedido = new PedidoData;
$clienteEmail = null; // Variable para almacenar el correo electrónico del cliente

if ($dataPedidos = $pedido->readByClientAndStatus($_SESSION['idCliente'], 'Pendiente')) {
    foreach ($dataPedidos as $rowPedido) {
        if ($clienteEmail === null) {
            // Obtener el correo electrónico del cliente una sola vez
            $clienteEmail = $rowPedido['correo_cliente'];
        }

        // Información del cliente
        $pdf->setFont('Arial', 'B', 10);
        $pdf->cell(0, 15, $pdf->encodeString('ID de Pedido: ' . $rowPedido['id_pedido']), 0, 1);
        $pdf->ln(2);

        $pdf->setFont('Arial', '', 11);
        $pdf->ln(5);
        // Primera fila de datos
        $pdf->cell(30, 8, $pdf->encodeString('Nombre:'), 0, 0);
        $pdf->cell(60, 8, $pdf->encodeString($rowPedido['nombre_cliente'] . ' ' . $rowPedido['apellido_cliente']), 0, 0);
        $pdf->cell(30, 8, $pdf->encodeString('Teléfono:'), 0, 0);
        $pdf->cell(70, 8, $pdf->encodeString($rowPedido['telefono_cliente']), 0, 1);
        $pdf->ln(5);

        // Segunda fila de datos
        $pdf->cell(30, 8, $pdf->encodeString('Dirección:'), 0, 0);
        $pdf->cell(60, 8, $pdf->encodeString($rowPedido['direccion_cliente']), 0, 0);
        $pdf->cell(30, 8, $pdf->encodeString('DUI:'), 0, 0);
        $pdf->cell(70, 8, $pdf->encodeString($rowPedido['dui_cliente']), 0, 1);
        $pdf->ln(5);

        // Tercera fila de datos
        $pdf->cell(50, 8, $pdf->encodeString('Correo Electrónico:'), 0, 0);
        $pdf->cell(50, 8, $pdf->encodeString($clienteEmail), 0, 0);
        $pdf->ln(13);
        $pdf->cell(50, 8, $pdf->encodeString('Fecha de Registro:'), 0, 0);
        $pdf->cell(50, 8, $pdf->encodeString($rowPedido['fecha_registro']), 0, 1);
        $pdf->ln(5);

        // Encabezados de productos
        $pdf->setFont('Arial', 'B', 11);
        $pdf->setFillColor(36, 92, 157);
        $pdf->setTextColor(255, 255, 255);
        $pdf->cell(126, 12, 'Producto', 0, 0, 'C', 1);
        $pdf->cell(30, 12, 'Cantidad', 0, 0, 'C', 1);
        $pdf->cell(30, 12, 'Precio (US$)', 0, 1, 'C', 1);

        $detallePedido = new PedidoData;
        if ($detallePedido->setIdPedido($rowPedido['id_pedido'])) {
            if ($dataDetalles = $detallePedido->readByPedido()) {

                $pdf->setFont('Arial', '', 11);
                $pdf->setFillColor(240, 240, 240);
                $pdf->setTextColor(0, 0, 0);
                $fill = false;
                $total = 0;
                foreach ($dataDetalles as $rowDetalle) {
                    $pdf->cell(126, 12, $pdf->encodeString($rowDetalle['nombre_producto']), 0, 0, '', $fill);
                    $pdf->cell(30, 12, $rowDetalle['cantidad_producto'], 0, 0, 'C', $fill);
                    $pdf->cell(30, 12, number_format($rowDetalle['precio_producto'], 2, '.', ''), 0, 1, 'R', $fill);
                    $total += $rowDetalle['cantidad_producto'] * $rowDetalle['precio_producto'];
                    $fill = !$fill;
                }
                $pdf->setFont('Arial', 'B', 11);
                $pdf->cell(150, 15, 'Total', 0, 0, 'R');
                $pdf->cell(35, 15, number_format($total, 2, '.', ''), 0, 1, 'R');
            } else {
                $pdf->cell(0, 10, $pdf->encodeString('No hay productos para el pedido'), 1, 1);
            }
        } else {
            $pdf->cell(0, 10, $pdf->encodeString('Pedido incorrecto o inexistente'), 1, 1);
        }

        $pdf->ln(10);
    }
} else {
    $pdf->ln(10);
    $pdf->setFont('Arial', '', 11);
    $pdf->cell(0, 15, $pdf->encodeString('Se envio un correo con el comprobante'), 1, 2);
}

$filePath = '../../pdfs/Comprobante_' . time() . '.pdf';
$pdf->output('F', $filePath);

// Mostrar el archivo en el navegador
$pdf->output('I', 'Comprobante.pdf');

echo "Archivo guardado en: " . $filePath;

// Usar realpath para asegurarse de que la ruta del archivo es correcta
$fileUrl = urlencode(realpath($filePath));
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "http://localhost/PTC_2024/api/reports/public/invoice.php?file=" . $fileUrl . "&email=" . urlencode($clienteEmail));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

echo $response;
