document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('supplier-form');
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
    const button = e.target.closest('.edit-supplier-button');
    if (button) {
        const id = button.dataset.id;
        const name = button.dataset.name;
        const address = button.dataset.address;
        const phone_number = button.dataset.phone_number;
        const rif = button.dataset.rif;

        document.querySelector('#edit_supplier-form input[name="name"]').value = name;
        document.querySelector('#edit_supplier-form input[name="address"]').value = address;
        document.querySelector('#edit_supplier-form input[name="phone_number"]').value = phone_number;
        document.querySelector('#edit_supplier-form input[name="rif"]').value = rif;

        const originalAction = document.getElementById('edit_supplier-form').getAttribute('data-base-action');
        document.getElementById('edit_supplier-form').setAttribute('action', originalAction.replace('0', id));

        const modal = new bootstrap.Modal(document.getElementById('edit-supplier-modal'));
        modal.show();
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const editForm = document.getElementById('edit_supplier-form');
    if (editForm) {
        editForm.addEventListener('submit', function (e) {
            e.preventDefault();

            const formData = new FormData(this);
            fetch(this.action, {
                method: 'POST',
                body: formData,
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRFToken': this.querySelector('[name=csrfmiddlewaretoken]').value
                }
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        Swal.fire('¡Actualizado!', data.message, 'success').then(() => {
                            // Cierra la modal correctamente con Bootstrap 5
                            const modalEl = document.getElementById('edit-supplier-modal');
                            const modalInstance = bootstrap.Modal.getInstance(modalEl);
                            if (modalInstance) modalInstance.hide();
                            // Ahora recarga la página
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('Error', data.message, 'error');
                    }
                })
                .catch(() => {
                    Swal.fire('Error', 'Ocurrió un error al procesar la solicitud.', 'error');
                });
        });
    }
});

//Eliminar
$(document).on('click', '.delete-supplier-button', function () {
    const supplierId = $(this).data('id');

    Swal.fire({
        title: '¿Eliminar relleno?',
        text: "Esta acción no se puede deshacer",
        icon: 'warning',
        showCancelButton: true,
        showConfirmButton: false,
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

            fetch(`/food_filling/supplier_delete/${supplierId}/`, {
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
                            text: 'El relleno ha sido eliminado correctamente.'
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

// Validación antes de enviar el formulario de registro y edición de proveedor
function validateSupplierForm(form) {
    const phoneInput = form.querySelector('input[name="phone_number"]');
    const rifInput = form.querySelector('input[name="rif"]');
    const phonePattern = /^\+58 \d{3}-\d{3}-\d{4}$/;
    const rifPattern = /^[CEGJPV]-\d{8}-\d$/;

    if (!phonePattern.test(phoneInput.value)) {
        Swal.fire({
            icon: 'error',
            title: 'Teléfono inválido',
            text: 'El número de teléfono debe tener el formato: +58 412-123-4567'
        });
        phoneInput.focus();
        return false;
    }
    if (!rifPattern.test(rifInput.value)) {
        Swal.fire({
            icon: 'error',
            title: 'RIF inválido',
            text: 'El RIF debe tener el formato: J-12345678-9'
        });
        rifInput.focus();
        return false;
    }
    return true;
}

// Registro proveedor
document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('supplier-form');
    if (form) {
        form.addEventListener('submit', function (e) {
            if (!validateSupplierForm(form)) {
                e.preventDefault();
                return false;
            }
        });
    }
});

// Edición proveedor
document.addEventListener('DOMContentLoaded', function () {
    const editForm = document.getElementById('edit_supplier-form');
    if (editForm) {
        editForm.addEventListener('submit', function (e) {
            if (!validateSupplierForm(editForm)) {
                e.preventDefault();
                return false;
            }
        });
    }
});