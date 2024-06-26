function Menu() {
    const Menu = `<nav class="navbar navbar-expand-lg">
    <div class="container-fluid d-flex justify-content-between align-items-center">
        <!-- Imágenes en la derecha en pantallas grandes y en el centro en pantallas pequeñas -->
        <div class="col-md d-md-none"></div> <!-- Espacio en blanco para separar las imágenes -->
        <div class="col-md-auto d-none d-sm-flex justify-content-start"> <!-- Se muestra en pantallas grandes -->
            <a href="/Vistas/Publico/index.html"><img src="/Api/Imagenes/Logo/Logo_Panaderia.png" height="90" width="90"></a>
        </div>

        <!-- Menú lateral -->
        <section class="offcanvas offcanvas-start" id="menuLateral" tabindex="-1">
            <div class="offcanvas-header" data-bs-theme="dark">
                <h5 class="offcanvas-title">Panaderia Hernández</h5>
                <button class="btn-close" type="button" aria-label="Close" data-bs-dismiss="offcanvas"></button>
            </div>
            <div class="offcanvas-body d-flex flex-column justify-content-between px-0">
                <ul class="navbar-nav fs-5 justify-content-evenly">
                    <li class="nav-item p-3 py-md-1">
                        <a href="/Vistas/Publico/contacto.html" class="nav-link">Contacto</a>
                    </li>
                    <li class="nav-item p-3 py-md-1">
                        <a href="/Vistas/Publico/productos.html" class="nav-link">Productos</a>
                    </li>
                    <li class="nav-item p-3 py-md-1">
                        <a href="/Vistas/Publico/nosotros.html" class="nav-link">Sobre nosotros</a>
                    </li>
                </ul>
            </div>
        </section>
        <div class="col-md d-md-none col-sm d-sm-none"></div> <!-- Espacio en blanco para separar las imágenes -->
        <div class="col-md-auto  col-sm-auto d-none d-sm-flex justify-content-end"> <!-- Se muestra en pantallas grandes -->
            <a href="/Vistas/Publico/favoritos.html"><img class="p-2" src="/Recursos/Imagenes/favoritos.png" height="70" width="70"></a>
            <a href="/Vistas/Publico/carrito.html"><img class="p-2" src="/Recursos/Imagenes/carrito.png" height="70" width="70"></a>
            <a href="/Vistas/Publico/cuenta.html"><img class="p-2" src="/Recursos/Imagenes/cuenta.png" height="70" width="70"></a>
        </div>

        <!-- Botón del menú a la derecha en pantallas pequeñas -->
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#menuLateral">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>`;

    return Menu;
}


