document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('create_food_type-form');
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(form);

            fetch(form.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRFToken': form.querySelector('[name=csrfmiddlewaretoken]').value
                }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        Swal.fire({
                            icon: 'success',
                            title: '¡Éxito!',
                            text: data.message
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: data.message
                        });
                    }
                })
                .catch(() => {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error inesperado',
                        text: 'Ocurrió un error al procesar la solicitud.'
                    });
                });
        });
    }
});

//Función para obtener el CSRF token
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            const cookie = cookies[i].trim();
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

//Editar
document.addEventListener('click', function (e) {
    if (e.target.closest('.edit-food_type-button')) {
        const button = e.target.closest('.edit-food_type-button');
        const id = button.dataset.id;

        fetch(`/food_type/get_food_type/${id}/`, {
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    const form = document.getElementById('edit_food_type-form');
                    const baseAction = form.getAttribute('data-base-action');
                    form.setAttribute('action', baseAction.replace('0', id));

                    form.querySelector('input[name="name"]').value = data.data.name;
                    form.querySelector('input[name="price"]').value = data.data.price;
                    $('#edit_food_type-form #id_fillings_quantities').val(JSON.stringify(data.data.quantities));
                    $('#edit_food_type-form #id_fillings').val(data.data.fillings.map(String)).trigger('change');
                    setTimeout(() => {
                        window.renderQuantityInputsEdit && window.renderQuantityInputsEdit();
                    }, 100);
                    const modal = new bootstrap.Modal(document.getElementById('edit-food_type-modal'));
                    modal.show();
                } else {
                    Swal.fire('Error', data.message, 'error');
                }
            });
    }
});


//Ocultar
$(document).on('click', '.toggle-food_type-button', function () {
    const food_type_id = $(this).data('id');
    const action = $(this).data('action');
    let url, title, text, confirmButtonText;

    if (action === 'deactivate') {
        url = `/food_type/food_type_delete/${food_type_id}/`;
        title = '¿Ocultar arepa?';
        text = 'La arepa ya no estará disponible para pedidos, pero no se eliminará.';
        confirmButtonText = 'Sí, ocultar';
    } else {
        url = `/food_type/food_type_restore/${food_type_id}/`;
        title = '¿Mostrar arepa?';
        text = 'La arepa volverá a estar disponible para pedidos.';
        confirmButtonText = 'Sí, mostrar';
    }

    Swal.fire({
        title: title,
        text: text,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: confirmButtonText,
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            $.post(url, { 'csrfmiddlewaretoken': getCookie('csrftoken') }, function (response) {
                if (response.success) {
                    Swal.fire('Listo', response.message, 'success').then(() => {
                        location.reload();
                    });
                } else {
                    Swal.fire('Error', response.message, 'error');
                }
            });
        }
    });
});

// Intercepta el submit del formulario de edición
$('#edit_food_type-form').on('submit', function (e) {
    var $form = $(this);
    var container = document.getElementById('edit-fillings-quantities-container');
    var hiddenInput = $form.find('input[name="fillings_quantities"]');
    if (container && hiddenInput.length) {
        var data = {};
        $(container).find('input[data-filling-id]').each(function () {
            data[$(this).data('filling-id')] = $(this).val();
        });
        hiddenInput.val(JSON.stringify(data));
    }
    e.preventDefault();
    var url = $form.attr('action');
    var data = $form.serialize();

    $.post(url, data, function (response) {
        if (response.status === 'success') {
            Swal.fire({
                icon: 'success',
                title: '¡Éxito!',
                text: response.message,
                confirmButtonText: 'OK'
            }).then(() => {
                // Cierra la modal correctamente con Bootstrap 5
                const modalEl = document.getElementById('edit-food_type-modal');
                const modalInstance = bootstrap.Modal.getInstance(modalEl);
                if (modalInstance) modalInstance.hide();
                // Ahora recarga la página
                location.reload();
            });
            // $('#edit-food_type-modal').modal('hide');
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: response.message
            });
        }
    });
});