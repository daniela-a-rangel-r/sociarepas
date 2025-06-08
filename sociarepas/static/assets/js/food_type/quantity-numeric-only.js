document.addEventListener('input', function (e) {
    if (e.target.classList.contains('quantity-numeric-only')) {
        // Solo números y máximo 11 caracteres
        e.target.value = e.target.value.replace(/[^0-9]/g, '').slice(0, 11);
    }
});