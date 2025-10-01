$(document).ready(function () {
    $('#datatable-dashboard').DataTable({
        language: {
            "lengthMenu": "Mostrar _MENU_ registros",
            "zeroRecords": "No se encontraron resultados",
            "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "infoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
            "infoFiltered": "(filtrado de un total de _MAX_ registros)",
            "sSearch": "Buscar:",
            "sProcessing": "Procesando...",
            "emptyTable": "No hay datos disponibles en la tabla",
            "oPaginate": {
                "sFirst": "Primero",
                "sLast": "Último",
                "sNext": "Siguiente",
                "sPrevious": "Anterior"
            },
        },
        paging: true,
        searching: true,
        responsive: {
            details: {
                type: 'inline', // Muestra los detalles debajo de la fila
                target: 'tr'    // El icono aparece en la fila completa
            }
        },
        lengthChange: true,
        columnDefs: [
            { responsivePriority: 1, targets: 0 }, // # (primera columna)
            { responsivePriority: 2, targets: 1 }, // Nombre (segunda columna)
            { responsivePriority: 3, targets: 2 }, // Cantidad disponible (tercera columna)
            { responsivePriority: 4, targets: -1 } // Opciones (última columna)
        ]
    });
});