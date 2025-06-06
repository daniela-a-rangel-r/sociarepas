document.addEventListener('DOMContentLoaded', function() {
    const loginSuccess = localStorage.getItem('loginSuccess');
    if (loginSuccess) {
        Swal.fire({
            icon: 'success',
            title: '¡Bienvenido!',
            text: loginSuccess,
            confirmButtonColor: '#3085d6'
        });
        localStorage.removeItem('loginSuccess');
    }
});