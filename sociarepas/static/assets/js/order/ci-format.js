document.addEventListener("DOMContentLoaded", function () {
    var idInputs = document.querySelectorAll('input[name="identity_number"]');
    idInputs.forEach(function (idInput) {
        idInput.addEventListener("input", function (e) {
            // Solo números, exactamente 8 dígitos
            e.target.value = e.target.value.replace(/\D/g, '').slice(0, 8);
        });
        idInput.addEventListener("blur", function (e) {
            // Validación: exactamente 8 dígitos
            const pattern = /^\d{8}$/;
            if (e.target.value && !pattern.test(e.target.value)) {
                e.target.setCustomValidity("La cédula debe tener exactamente 8 dígitos.");
            } else {
                e.target.setCustomValidity("");
            }
        });
    });
});