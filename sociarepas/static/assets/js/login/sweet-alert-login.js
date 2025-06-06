document.addEventListener('DOMContentLoaded', function () {
    const form = document.getElementById('login-form');
    if (form) {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            const formData = new FormData(form);
            fetch("", {
                method: "POST",
                headers: {
                    'X-CSRFToken': formData.get('csrfmiddlewaretoken')
                },
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        localStorage.setItem('loginSuccess', data.message);
                        window.location.href = data.redirect_url;
                    } else {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: data.message,
                            confirmButtonColor: '#d33'
                        });
                    }
                });
        });
    }
});