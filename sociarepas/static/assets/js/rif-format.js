document.addEventListener("DOMContentLoaded", function () {
    var rifInputs = document.querySelectorAll('input[name="rif"]');
    rifInputs.forEach(function (rifInput) {
        rifInput.addEventListener("input", function (e) {
            let value = e.target.value.toUpperCase().replace(/[^CEGJPV0-9]/g, "");
            if (value.length > 1) value = value.slice(0, 1) + "-" + value.slice(1);
            if (value.length > 10)
                value = value.slice(0, 10) + "-" + value.slice(10, 11);
            e.target.value = value;
        });
        rifInput.addEventListener("blur", function (e) {
            // Validación básica: formato X-########-#
            const rifPattern = /^[CEGJPV]-\d{8}-\d$/;
            if (e.target.value && !rifPattern.test(e.target.value)) {
                e.target.setCustomValidity("Formato de RIF inválido. Ejemplo: J-12345678-9");
            } else {
                e.target.setCustomValidity("");
            }
        });
    });
});