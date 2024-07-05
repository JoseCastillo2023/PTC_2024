/*
*   Controlador de uso general en las páginas web del sitio privado.
*   Sirve para manejar la plantilla del encabezado y pie del documento.
*/

// Constante para completar la ruta de la API.
const USER_API = 'services/admin/administrador.php';
// Constante para establecer el elemento del contenido principal.
const MAIN = document.querySelector('main');
MAIN.style.paddingTop = '75px';
MAIN.style.paddingBottom = '100px';
MAIN.classList.add('container');
// Se establece el título de la página web.
document.querySelector('title').textContent = 'Panaderia Hernández - Dashboard';
// Constante para establecer el elemento del título principal.
const MAIN_TITLE = document.getElementById('mainTitle');
MAIN_TITLE.classList.add('text-center', 'py-3');

/*  Función asíncrona para cargar el encabezado y pie del documento.
*   Parámetros: ninguno.
*   Retorno: ninguno.
*/
const loadTemplate = async () => {
    // Petición para obtener en nombre del usuario que ha iniciado sesión.
    const DATA = await fetchData(USER_API, 'getUser');
    // Se verifica si el usuario está autenticado, de lo contrario se envía a iniciar sesión.
    if (DATA.session) {
        // Se comprueba si existe un alias definido para el usuario, de lo contrario se muestra un mensaje con la excepción.
        if (DATA.status) {
            // Se agrega el encabezado de la página web antes del contenido principal.

            // Menu funcionalidad.
            MAIN.insertAdjacentHTML('beforebegin', `
            <header>
    <nav class="navbar">
        <div class="container-fluid">
            <a class=" " href="#">
                <img src="../../resources/img/logo_pan.png" alt="Bootstrap" width="70" height="70" type="button"
                    data-bs-toggle="offcanvas" data-bs-target="#staticBackdrop" aria-controls="staticBackdrop">
            </a>
            <div class="d-flex position-absolute top-0 end-0 me-3 mt-2" >
                <a href="../../views/admin/profile.html" style="margin-right: 10px; margin-top: 10px;">
                    <img src="../../resources/img/user_avatar.png" width="50" height="50">
                </a>
                <a href="#" onclick="logOut()" style="margin-top: 10px;">
                    <img src="../../resources/img/logout.png" width="45" height="45">
                </a>
            </div>
            <!-- Offcanvas menu -->
            <div class="offcanvas offcanvas-start" style="background-color: #F1EFEF; border-top-right-radius: 30px; border-bottom-right-radius: 30px;"
                data-bs-backdrop="static" tabindex="-1" id="staticBackdrop" aria-labelledby="staticBackdropLabel">
                <div class="offcanvas-header">
                    <h3 class="offcanvas-title" id="staticBackdropLabel">Menú</h3>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="dashboard.html">Inicio</a></li>
                                        <li class="list-group-item"><a href="administrador.html">Administradores</a></li>
                                        <li class="list-group-item" id="modelo"><a href="categoria.html">Categorías</a></li>
                                        <li class="list-group-item" id="tipon"><a href="cliente.html">Clientes</a></li>
                                        <li class="list-group-item" id="tipon"><a href="valoracion.html">Comentarios</a></li>
                                        <li class="list-group-item" id="talla"><a href="producto.html">Productos</a></li>
                                        <li class="list-group-item" id="pedido"><a href="pedido.html">Pedidos</a></li>

                      </ul>
                </div>
            </div>
        </div>
    </nav>
</header>
            `);

            // Pie de página funcionalidad.
            // Se agrega el pie de la página web después del contenido principal.
            MAIN.insertAdjacentHTML('afterend', `
                <footer>
                    <nav class="navbar fixed-bottom bg-body-tertiary">
                        <div class="container">
                            <div>
                                <p><a class="nav-link" href="https://github.com/JoseCastillo2023/PTC_2024" target="_blank"><i class="bi bi-github"></i> Proyecto </a></p>
                                <p><i class="bi bi-c-square-fill"></i> 2024 Todos los derechos reservados</p>
                            </div>
                            <div>
                                <p><a class="nav-link" href="../public/" target="_blank"><i class="bi bi-cart-fill"></i> Sitio público</a></p>
                                <p><i class="bi bi-envelope-fill"></i> panaderiahern_sv@gmail.com</p>
                            </div>
                        </div>
                    </nav>
                </footer>
            `);
        } else {
            sweetAlert(3, DATA.error, false, 'index.html');
        }
    } else {

        // HEADER DEL Primer Uso y Login.
        // Se comprueba si la página web es la principal, de lo contrario se direcciona a iniciar sesión.
        if (location.pathname.endsWith('index.html')) {
            // Se agrega el encabezado de la página web antes del contenido principal.
            MAIN.insertAdjacentHTML('beforebegin', `
                <header>
                    <nav class="navbar fixed-top">
                        <div class="container">
                            <a class="navbar-brand" href="index.html">
                                <img src="../../resources/img/logo_pan.png" alt="inventory" width="50">
                            </a>
                        </div>
                    </nav>
                </header>
            `);

            // FOOTER DEL Primer Uso y Login.
            // Se agrega el pie de la página web después del contenido principal.
            MAIN.insertAdjacentHTML('afterend', `
                <footer>
                    <nav class="navbar fixed-bottom bg-body-tertiary">
                        <div class="container">
                            <p><a class="nav-link" href="https://github.com/JoseCastillo2023/PTC_2024" target="_blank"><i class="bi bi-github"></i> Proyecto </a></p>
                            <p><i class="bi bi-envelope-fill"></i> panaderiahern_sv@gmail.com</p>
                        </div>
                    </nav>
                </footer>
            `);
        } else {
            location.href = 'index.html';
        }
    }
}