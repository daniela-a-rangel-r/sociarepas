// Inicializa Select2 solo cuando se muestra el modal, destruyendo antes si es necesario

function initSelect2Supplier(modalSelector) {
    const $modal = $(modalSelector);
    const $select = $modal.find('select[name="fk_supplier"]');
    if ($select.length && window.$ && $.fn.select2) {
        if ($select.hasClass("select2-hidden-accessible")) {
            $select.select2('destroy');
        }
        $select.select2({
            dropdownParent: $modal,
            width: '100%',
        });
    }
}

$(function () {
    // Solo inicializa Select2 cuando se muestra el modal
    $('#register-food_filling-modal').on('shown.bs.modal', function () {
        initSelect2Supplier('#register-food_filling-modal');
    });
    $('#edit-food_filling-modal').on('shown.bs.modal', function () {
        initSelect2Supplier('#edit-food_filling-modal');
    });
});