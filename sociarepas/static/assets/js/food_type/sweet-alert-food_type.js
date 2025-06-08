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
document.querySelectorAll('.edit-food_type-button').forEach(button => {
    button.addEventListener('click', function () {
        const id = this.dataset.id;

        fetch(`/food_type/get_food_type/${id}/`, {
            headers: {
                'X-Requested-With': 'XMLHttpRequest'
            }
        })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                if (data.status === 'success') {
                    const form = document.getElementById('edit_food_type-form');
                    const baseAction = form.getAttribute('data-base-action');
                    form.setAttribute('action', baseAction.replace('0', id));

                    form.querySelector('input[name="name"]').value = data.data.name;
                    form.querySelector('input[name="price"]').value = data.data.price;

                    $('#edit_food_type-form #id_fillings').val(data.data.fillings.map(String)).trigger('change');
                    $('#edit_food_type-form #id_fillings_quantities').val(JSON.stringify(data.data.quantities));

                    setTimeout(() => {
                        window.renderQuantityInputsEdit && window.renderQuantityInputsEdit();
                    }, 300);

                    // Mostrar el modal
                    const modal = new bootstrap.Modal(document.getElementById('edit-food_type-modal'));
                    modal.show();
                } else {
                    Swal.fire('Error', data.message, 'error');
                }
            });
    });
});


//Eliminar
$(document).on('click', '.delete-food_type-button', function () {
    const food_typeId = $(this).data('id');

    Swal.fire({
        title: '¿Eliminar arepa?',
        text: "Esta acción no se puede deshacer",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire({
                title: 'Eliminando...',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            fetch(`/food_type/food_type_delete/${food_typeId}/`, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': getCookie('csrftoken'),
                    'Content-Type': 'application/json'
                },
                body: ''
            })
                .then(async response => {
                    Swal.close();
                    let data;
                    try {
                        data = await response.json();
                    } catch {
                        data = { success: false, message: 'Respuesta inválida del servidor' };
                    }
                    if (response.ok && data.success) {
                        Swal.fire({
                            icon: 'success',
                            title: '¡Eliminado!',
                            text: 'La arepa ha sido eliminada correctamente.'
                        }).then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('Error', data.message || 'Error al eliminar', 'error');
                    }
                })
                .catch(error => {
                    Swal.close();
                    console.error('Error:', error);
                    Swal.fire('Error', 'No se pudo completar la eliminación', 'error');
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
                // Opcional: recarga la página o actualiza la tabla
                location.reload();
            });
            $('#edit-food_type-modal').modal('hide');
        } else {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: response.message
            });
        }
    });
});