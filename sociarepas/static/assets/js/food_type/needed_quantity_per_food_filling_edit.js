document.addEventListener('DOMContentLoaded', function () {
    const fillingsSelect = document.querySelector('#edit_food_type-form #id_fillings');
    const container = document.getElementById('edit-fillings-quantities-container');
    const hiddenInput = document.querySelector('#edit_food_type-form #id_fillings_quantities');

    // Cargar cantidades actuales si existen
    let initialQuantities = {};
    if (hiddenInput && hiddenInput.value) {
        try {
            initialQuantities = JSON.parse(hiddenInput.value);
        } catch (e) { }
    }

    function renderQuantityInputs() {
        if (!fillingsSelect || !container) return;

        // ACTUALIZA initialQuantities cada vez que se renderiza
        if (hiddenInput && hiddenInput.value) {
            try {
                initialQuantities = JSON.parse(hiddenInput.value);
            } catch (e) {
                initialQuantities = {};
            }
        } else {
            initialQuantities = {};
        }

        // Guarda los valores actuales antes de limpiar
        const currentValues = {};
        container.querySelectorAll('input[data-filling-id]').forEach(input => {
            currentValues[input.dataset.fillingId] = input.value;
        });

        container.innerHTML = '';
        let selected = [];
        if (window.jQuery && $(fillingsSelect).data('select2')) {
            selected = $(fillingsSelect).val() || [];
        } else {
            selected = Array.from(fillingsSelect.selectedOptions).map(opt => opt.value);
        }
        selected.forEach(id => {
            let name = '';
            if (window.jQuery && $(fillingsSelect).data('select2')) {
                name = $(fillingsSelect).find('option[value="' + id + '"]').text();
            } else {
                const opt = fillingsSelect.querySelector('option[value="' + id + '"]');
                name = opt ? opt.text : '';
            }
            const div = document.createElement('div');
            div.className = 'mb-2';
            // Usa el valor guardado si existe, si no, pon el inicial, si no, 100
            const value = currentValues[id] !== undefined
                ? currentValues[id]
                : (initialQuantities[id] !== undefined ? initialQuantities[id] : '100');
            div.innerHTML = `
            <label>Cantidad para ${name} (en gr)</label>
            <input type="text" min="1" class="form-control numeric-only mb-1" name="filling_qty_${id}" data-filling-id="${id}" value="${value}">
        `;
            container.appendChild(div);
        });
        updateHiddenInput();
    }

    function updateHiddenInput() {
        if (!container || !hiddenInput) return;
        const inputs = container.querySelectorAll('input[data-filling-id]');
        const data = {};
        inputs.forEach(input => {
            data[input.dataset.fillingId] = input.value;
        });
        hiddenInput.value = JSON.stringify(data);
    }

    if (fillingsSelect) {
        $(fillingsSelect).on('change', renderQuantityInputs);
    }
    if (container) {
        container.addEventListener('input', updateHiddenInput);
    }

    renderQuantityInputs();

    window.renderQuantityInputsEdit = renderQuantityInputs;
});