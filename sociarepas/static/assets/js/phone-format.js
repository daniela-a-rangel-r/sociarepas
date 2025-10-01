document.addEventListener("DOMContentLoaded", function () {
    var phoneInputs = document.querySelectorAll('input[name="phone"], input[name="phone_number"]');
    phoneInputs.forEach(function (phoneInput) {
        if (phoneInput.value.trim() === "") {
            phoneInput.value = "+58 ";
        }
        phoneInput.addEventListener("input", function (e) {
            let value = e.target.value.replace(/\D/g, "");
            if (!value.startsWith("58")) {
                value = "58" + value.replace(/^0+/, "");
            }
            if (value.length > 2 && value[2] === "0") {
                value = value.slice(0, 2) + value.slice(3);
            }
            value = value.slice(0, 12);
            let formatted = "+58 ";
            if (value.length > 2) {
                formatted += value.slice(2, 5);
            }
            if (value.length > 5) {
                formatted += "-" + value.slice(5, 8);
            }
            if (value.length > 8) {
                formatted += "-" + value.slice(8, 12);
            }
            e.target.value = formatted;
        });
        phoneInput.addEventListener("keydown", function (e) {
            if (
                this.selectionStart <= 4 &&
                (e.key === "Backspace" || e.key === "Delete")
            ) {
                e.preventDefault();
            }
        });
        phoneInput.addEventListener("blur", function (e) {
            // Validación básica: +58 XXX-XXX-XXXX
            const phonePattern = /^\+58 (412|414|416|422|424|426|212)-\d{3}-\d{4}$/;
            if (e.target.value && !phonePattern.test(e.target.value)) {
                e.target.setCustomValidity("Formato de teléfono inválido. Ejemplo: +58 412-123-4567");
            } else {
                e.target.setCustomValidity("");
            }
        });
    });
});