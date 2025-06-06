// Inicializa Select2 solo cuando se abre el modal de registro
$('#register-food_type-modal').on('shown.bs.modal', function () {
    var $select = $(this).find('select[multiple]');
    if ($select.hasClass("select2-hidden-accessible")) {
        $select.select2('destroy');
    }
    $select.select2({
        width: '100%',
        placeholder: 'Selecciona uno o más rellenos'
    });
});

// Destruye Select2 al cerrar el modal de registro
$('#register-food_type-modal').on('hidden.bs.modal', function () {
    var $select = $(this).find('select[multiple]');
    if ($select.hasClass("select2-hidden-accessible")) {
        $select.select2('destroy');
    }
});

// Inicializa Select2 solo cuando se abre el modal de edición
$('#edit-food_type-modal').on('shown.bs.modal', function () {
    var $select = $(this).find('select[multiple]');
    if ($select.hasClass("select2-hidden-accessible")) {
        $select.select2('destroy');
    }
    $select.select2({
        width: '100%',
        placeholder: 'Selecciona uno o más rellenos'
    });
});

// Destruye Select2 al cerrar el modal de edición
$('#edit-food_type-modal').on('hidden.bs.modal', function () {
    var $select = $(this).find('select[multiple]');
    if ($select.hasClass("select2-hidden-accessible")) {
        $select.select2('destroy');
    }
});

// Cuando se abre la modal de edición, actualiza los valores seleccionados
$('.edit-food_type-button').on('click', function () {
    var foodTypeId = $(this).data('id');
    $.ajax({
        url: '/food_type/get_food_type/' + foodTypeId + '/',
        type: 'GET',
        headers: { 'X-Requested-With': 'XMLHttpRequest' },
        success: function (response) {
            if (response.status === 'success') {
                var fillings = response.data.fillings;
                $('#edit-food_type-modal select[multiple]').val(fillings).trigger('change');
                var baseAction = $('#edit_food_type-form').data('base-action');
                $('#edit_food_type-form').attr('action', baseAction.replace('0', foodTypeId));
                $('#edit-food_type-modal').modal('show');
            }
        }
    });
});
