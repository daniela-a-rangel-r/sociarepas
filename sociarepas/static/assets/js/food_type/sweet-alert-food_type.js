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
            if (data.status === 'success') {
                const form = document.getElementById('edit_food_type-form');
                const baseAction = form.getAttribute('data-base-action');
                form.setAttribute('action', baseAction.replace('0', id));

                form.querySelector('input[name="name"]').value = data.data.name;
                form.querySelector('input[name="price"]').value = data.data.price;

                // Preseleccionar rellenos
                const selectedFillings = data.data.fillings.map(String); // asegúrate que sean strings
                const options = form.querySelectorAll('select[name="fillings"] option, input[name="fillings"]');

                options.forEach(option => {
                    if (selectedFillings.includes(option.value)) {
                        option.selected = true; // para select
                        option.checked = true;  // para checkbox
                    } else {
                        option.selected = false;
                        option.checked = false;
                    }
                });

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