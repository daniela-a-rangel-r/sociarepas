document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.numeric-only').forEach(function (input) {
        input.addEventListener('input', function () {
            // Permitir solo números y un solo punto decimal
            let value = this.value;

            // Eliminar cualquier carácter que no sea número o punto
            value = value.replace(/[^0-9.]/g, '');

            // Si hay más de un punto, eliminar los adicionales
            const parts = value.split('.');
            if (parts.length > 2) {
                value = parts[0] + '.' + parts[1];
            }

            // Limitar a 2 decimales si hay parte decimal
            if (parts.length === 2) {
                parts[1] = parts[1].substring(0, 2);
                value = parts[0] + '.' + parts[1];
            }

            this.value = value;
        });
    });
});
