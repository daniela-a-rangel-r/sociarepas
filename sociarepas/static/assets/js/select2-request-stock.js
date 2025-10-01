// Inicializa Select2 para el select de proveedor en la modal de stock
document.addEventListener('DOMContentLoaded', function () {
    const supplierSelect = document.querySelector('#request-stock-form select[name="fk_supplier"]');
    if (supplierSelect && window.$ && $.fn.select2) {
        $(supplierSelect).select2({
            dropdownParent: $('#request-stock-modal'),
            width: '100%',
        });
    }
});