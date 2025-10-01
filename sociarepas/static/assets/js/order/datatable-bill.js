$(document).ready(function () {
    $('#datatable-bill').DataTable({
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
        responsive: true,
        lengthChange: true,
    });
});

document.addEventListener('click', function (e) {
    const btn = e.target.closest('.generate-pdf-btn');
    if (btn) {
        let row = btn.closest('tr');
        let columns = [];

        // Si el botón está en la fila child (modo responsive)
        if (row.classList.contains('child')) {
            // La fila principal es la anterior
            const mainRow = row.previousElementSibling;
            columns = Array.from(mainRow.querySelectorAll('td')).slice(1, 5).map(td => (td.innerText || '-').trim());

            // Si aún faltan datos, intenta obtenerlos de los <li> de la fila child
            if (columns.length < 4 || columns.some(col => col === '-')) {
                const lis = Array.from(row.querySelectorAll('li'));
                columns = lis.slice(0, 4).map(li => (li.innerText || '-').trim());
            }
        } else {
            // Botón en la fila principal
            columns = Array.from(row.querySelectorAll('td')).slice(1, 5).map(td => (td.innerText || '-').trim());

            // Si faltan datos, busca en la fila child siguiente
            if (columns.length < 4 || columns.some(col => col === '-')) {
                const childRow = row.nextElementSibling;
                if (childRow && childRow.classList.contains('child')) {
                    const lis = Array.from(childRow.querySelectorAll('li'));
                    columns = lis.slice(0, 4).map(li => (li.innerText || '-').trim());
                }
            }
        }

        // Validación: si faltan columnas, no genera el PDF
        if (columns.length < 4 || columns.some(col => col === '-')) {
            alert('No se encontraron los datos necesarios para generar la factura.');
            return;
        }

        const { jsPDF } = window.jspdf;
        const doc = new jsPDF({
            orientation: "portrait",
            unit: "mm",
            format: [80, 150] // Ticket size
        });

        // Encabezado
        doc.setFontSize(16);
        doc.setTextColor(40, 40, 40);
        doc.setFont('helvetica', 'bold');
        doc.text('SOCIAREPAS', 40, 12, { align: 'center' });

        doc.setFontSize(9);
        doc.setTextColor(100, 100, 100);
        doc.setFont('helvetica', 'normal');
        doc.text('RIF: 295038442', 40, 17, { align: 'center' });
        doc.text('Tel: +58 412-9167709', 40, 22, { align: 'center' });

        // Línea divisoria
        doc.setDrawColor(180, 180, 180);
        doc.setLineWidth(0.5);
        doc.line(8, 25, 72, 25);

        // Título Factura
        doc.setFontSize(12);
        doc.setTextColor(60, 60, 60);
        doc.setFont('helvetica', 'bold');
        doc.text('Factura de Venta', 40, 31, { align: 'center' });

        // Recuadro de datos del cliente y factura
        doc.setDrawColor(60, 60, 60);
        doc.setLineWidth(0.3);
        doc.roundedRect(8, 35, 64, 18, 2, 2, 'S');

        doc.setFontSize(9);
        doc.setTextColor(40, 40, 40);
        doc.setFont('helvetica', 'normal');
        doc.text('Cliente:', 12, 42);
        doc.setFont('helvetica', 'bold');
        doc.text(columns[0] || '-', 28, 42);

        doc.setFont('helvetica', 'normal');
        doc.text('Método de Pago:', 12, 49);
        doc.setFont('helvetica', 'bold');
        doc.text(columns[3] || '-', 38, 49);

        // Tabla de productos (más pequeña)
        doc.setFont('helvetica', 'normal');
        doc.autoTable({
            startY: 58,
            margin: { left: 12, right: 12 },
            head: [['Cantidad', 'Precio']],
            body: [
                [columns[1] || '-', columns[2] || '-']
            ],
            theme: 'grid',
            headStyles: { fillColor: [220, 53, 69], halign: 'center', fontSize: 9 },
            bodyStyles: { halign: 'center', fontSize: 9 },
            styles: { fontSize: 9, cellPadding: 1.5 }
        });

        // Total alineado con la tabla
        const tableLeft = 12;
        const tableRight = 68;
        const totalY = doc.lastAutoTable.finalY + 8;

        doc.setFontSize(11);
        doc.setTextColor(40, 40, 40);
        doc.setFont('helvetica', 'bold');
        doc.text('Total:', tableLeft, totalY);
        doc.text(columns[2] || '-', tableRight, totalY, { align: 'right' });

        // Pie de página
        doc.setFontSize(9);
        doc.setTextColor(150, 150, 150);
        doc.setFont('helvetica', 'normal');
        doc.text('Gracias por su compra', 40, 142, { align: 'center' });

        doc.save('factura.pdf');
    }
});