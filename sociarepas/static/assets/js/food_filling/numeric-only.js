document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.numeric-only').forEach(function (input) {
        input.addEventListener('input', function () {
            // Permitir solo números enteros
            this.value = this.value.replace(/[^0-9]/g, ''); // Eliminar cualquier carácter que no sea número
        });
    });
});