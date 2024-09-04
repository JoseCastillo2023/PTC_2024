<?php
// Se incluye la clase con las plantillas para generar reportes.
require_once ('../../helpers/report.php');
// Se incluyen las clases para el acceso a datos de clientes.
require_once ('../../models/data/administrador_data.php');

// Se instancia la clase para crear el reporte.
$pdf = new Report;
// Se inicia el reporte con el encabezado del documento.
$pdf->startReport('Administradores registrados');


// Se instancia el modelo Cliente para obtener los datos.
$AdminModel = new AdministradorData;
// Se verifica si existen registros para mostrar, de lo contrario se imprime un mensaje.
if ($dataAdmins = $AdminModel->readAll()) {
    // Se establece un color de relleno para los encabezados.
    $pdf->setFillColor(255, 165, 0);
    $pdf->setTextColor(0, 0, 0);
    // Se establece la fuente para los encabezados.
    $pdf->setFont('Arial', 'B', 11);

    // Encabezados
    $pdf->cell(10, 10, 'ID', 1, 0, 'C', 1);
    $pdf->cell(35, 10, 'Nombre', 1, 0, 'C', 1);
    $pdf->cell(35, 10, 'Apellido', 1, 0, 'C', 1);
    $pdf->cell(60, 10, 'Correo', 1, 0, 'C', 1);
    $pdf->cell(40, 10, 'Usuario', 1, 1, 'C', 1);

    // Se establece la fuente para los datos de los clientes.
    $pdf->setFont('Arial', '', 11);

    // Recorremos los datos de los clientes
    foreach ($dataAdmins as $administrador) {
        $pdf->setTextColor(0, 0, 0);
        // ID del cliente
        $pdf->cell(10, 10, $administrador['id_administrador'], 1, 0, 'C');

        // Nombre
        $pdf->cell(35, 10, $pdf->encodeString($administrador['nombre_administrador']), 1, 0, 'C');

        // Apellido
        $pdf->cell(35, 10, $pdf->encodeString($administrador['apellido_administrador']), 1, 0, 'C');

        // Correo
        $pdf->cell(60, 10, $administrador['correo_administrador'], 1, 0, 'C');

        // DUI del cliente
        $pdf->cell(40, 10, $administrador['alias_administrador'], 1, 1, 'C');
    }
} else {
    // Si no hay clientes registrados
    $pdf->cell(200, 10, $pdf->encodeString('No hay administradores registrados'), 1, 1, 'C');
}

// Se llama implícitamente al método footer() y se envía el documento al navegador web.
$pdf->output('I', 'Administradores.pdf');
?>