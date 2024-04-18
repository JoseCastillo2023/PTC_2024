document.addEventListener('DOMContentLoaded', function(){
    const ContenedorMenu = document.getElementById("menu_contenedor");
    const menuHTML = Menu();

    ContenedorMenu.innerHTML = menuHTML;
})