document.addEventListener('DOMContentLoaded', function(){
    const ContenedorFooter = document.getElementById("footer_contenedor");
    const footerHTML = Footer();

    ContenedorFooter.innerHTML = footerHTML;
})