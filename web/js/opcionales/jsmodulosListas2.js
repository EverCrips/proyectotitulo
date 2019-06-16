$('#UsuariosInactivos').dataTable({
    "ordering":false,
    "lengthMenu": [5, 10, 25],
    "scrollX":true,
    "language": {
        "lengthMenu": "Ver _MENU_",
        "info": "Mostrando _START_ a _END_ de _TOTAL_ resultados",
        "infoFiltered": "(filtrado de _MAX_ resultados totales)",
        "search": "Buscar",
        "paginate": {
            "next": "Siguiente",
            "previous":"Anterior"
        }
    }
});
$('#operacionesEnMarcha').dataTable({
    "ordering":false,
    "lengthMenu": [5, 10, 25],
    "scrollX":true,
    "language": {
        "lengthMenu": "Ver _MENU_",
        "info": "Mostrando _START_ a _END_ de _TOTAL_ resultados",
        "infoFiltered": "(filtrado de _MAX_ resultados totales)",
        "search": "Buscar",
        "paginate": {
            "next": "Siguiente",
            "previous":"Anterior"
        }
    }
});