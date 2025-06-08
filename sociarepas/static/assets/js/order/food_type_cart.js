//Contador de arepas
function increment(btn) {
    const counterValue = btn.parentElement.querySelector('.counter-value');
    let value = parseInt(counterValue.textContent);
    counterValue.textContent = value + 1;
}

function decrement(btn) {
    const counterValue = btn.parentElement.querySelector('.counter-value');
    let value = parseInt(counterValue.textContent);
    if (value > 1) {
        counterValue.textContent = value - 1;
    }
}

// Filtro de cartas por nombre
document.addEventListener('DOMContentLoaded', function () {
    const searchInput = document.getElementById('searchInput');
    const cards = document.querySelectorAll('.order-card');

    searchInput.addEventListener('input', function () {
        const filter = searchInput.value.toLowerCase();
        cards.forEach(card => {
            const title = card.querySelector('.order-title').textContent.toLowerCase();
            if (title.includes(filter)) {
                card.style.display = '';
            } else {
                card.style.display = 'none';
            }
        });
    });
});


//Inicializar modal de carrito

// Mostrar modal al hacer clic en el carrito
document.addEventListener('DOMContentLoaded', function () {
    const cartButton = document.getElementById('cartButton');
    cartButton.addEventListener('click', function () {
        var cartModal = new bootstrap.Modal(document.getElementById('cartModal'));
        cartModal.show();
    });
});

//Script para manejar el carrito y los valores introducidos

// Carrito en memoria
let cart = {};

// Función para añadir productos al carrito
function addToCart(btn) {
    const card = btn.closest('.order-card');
    const title = card.querySelector('.order-title').textContent;
    const imgSrc = card.querySelector('img').src;
    const quantity = parseInt(card.querySelector('.counter-value').textContent);
    // Obtener el precio desde el texto (ej: "Precio: 10 $")
    const priceText = card.querySelector('.order-date').textContent;
    const price = parseFloat(priceText.replace(/[^\d.]/g, ''));

    if (cart[title]) {
        cart[title].quantity += quantity;
    } else {
        cart[title] = {
            img: imgSrc,
            quantity: quantity,
            price: price
        };
    }
    updateCartModal();
    updateCartCount();
}

// Eliminar producto del carrito
function removeFromCart(title) {
    delete cart[title];
    updateCartModal();
    updateCartCount();
}

// Disminuir cantidad desde el carrito
function decreaseFromCart(title) {
    if (cart[title]) {
        if (cart[title].quantity > 1) {
            cart[title].quantity -= 1;
        } else {
            delete cart[title];
        }
        updateCartModal();
        updateCartCount();
    }
}

// Actualiza el contenido del modal del carrito con formato tabla y total
function updateCartModal() {
    const cartItems = document.getElementById('cart-items');
    const emptyMsg = document.getElementById('cart-empty-msg');
    cartItems.innerHTML = '';

    const keys = Object.keys(cart);
    let total = 0;
    if (keys.length === 0) {
        emptyMsg.style.display = '';
    } else {
        emptyMsg.style.display = 'none';
        // Tabla
        let table = document.createElement('table');
        table.className = "table table-bordered align-middle mb-0";
        table.innerHTML = `
                <thead>
                    <tr>
                        <th>Imagen</th>
                        <th>Arepa</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            `;
        keys.forEach(title => {
            const item = cart[title];
            const subtotal = item.price * item.quantity;
            total += subtotal;
            let row = document.createElement('tr');
            row.innerHTML = `
                    <td><img src="${item.img}" alt="Arepa" style="width:32px;height:32px;border-radius:50%;background:#eee;"></td>
                    <td>${title}</td>
                    <td><span class="badge bg-primary">${item.quantity}</span></td>
                    <td>${subtotal.toFixed(2)} $</td>
                    <td>
                        <button class="btn btn-sm btn-warning me-1" onclick="decreaseFromCart('${title.replace(/'/g, "\\'")}')">
                            <i class='bx bx-minus'></i>
                        </button>
                        <button class="btn btn-sm btn-danger" onclick="removeFromCart('${title.replace(/'/g, "\\'")}')">
                            <i class='bx bx-x'></i>
                        </button>
                    </td>
                `;
            table.querySelector('tbody').appendChild(row);
        });
        // Fila de total
        let totalRow = document.createElement('tr');
        totalRow.innerHTML = `
                <td colspan="3" class="text-end fw-bold">Total</td>
                <td colspan="2" class="fw-bold">${total.toFixed(2)} $</td>
            `;
        table.querySelector('tbody').appendChild(totalRow);

        cartItems.appendChild(table);
    }
}

// Calcula el total del carrito
function getCartTotal() {
    let total = 0;
    Object.values(cart).forEach(item => {
        total += item.price * item.quantity;
    });
    return total.toFixed(2);
}

function showClientModal() {
    // Verifica si el carrito está vacío
    if (Object.keys(cart).length === 0) {
        Swal.fire({
            icon: 'error',
            title: 'Carrito vacío',
            text: 'Debes agregar al menos una arepa antes de continuar.'
        });
        return; // No continúa si el carrito está vacío
    }
    const cartData = cart; // Obtiene el carrito actual

    verifyStockModal(cartData).then(data => {
        if (data.success === false) {
            Swal.fire({
                icon: 'error',
                title: 'Stock insuficiente',
                text: data.message
            });
        } else {
            // Cierra el modal del carrito
            var cartModal = bootstrap.Modal.getInstance(document.getElementById('cartModal'));
            cartModal.hide();

            // Muestra el spinner de carga
            var loadingModal = new bootstrap.Modal(document.getElementById('loadingModal'));
            loadingModal.show();

            // Espera 1.2 segundos y muestra la modal de datos del cliente
            setTimeout(function () {
                loadingModal.hide();
                // Actualiza el total en la modal de cliente
                document.getElementById('clientModalTotal').textContent = getCartTotal() + ' $';
                var clientModal = new bootstrap.Modal(document.getElementById('clientModal'));
                clientModal.show();
            }, 1200);
        }
    }).catch(() => {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'No se pudo verificar el stock. Intenta de nuevo.'
        });
    });
}

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('clientForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const form = e.target;
        const formData = new FormData(form);
        formData.append('cart', JSON.stringify(cart));
        fetch(window.processOrderUrl, {
            method: 'POST',
            headers: {
                'X-CSRFToken': window.csrfToken
            },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    Swal.fire({
                        icon: 'success',
                        title: '¡Pedido realizado con éxito!',
                        text: 'Gracias por tu compra.',
                        confirmButtonColor: '#3085d6'
                    });
                    // Limpia el carrito y cierra el modal
                    cart = {};
                    updateCartModal();
                    updateCartCount();
                    var clientModal = bootstrap.Modal.getInstance(document.getElementById('clientModal'));
                    clientModal.hide();
                } else {
                    alert('Error: ' + data.message);
                }
            });
    });
});

function backToCart() {
    // Cierra la modal de cliente
    var clientModal = bootstrap.Modal.getInstance(document.getElementById('clientModal'));
    clientModal.hide();
    // Abre la modal del carrito
    setTimeout(function () {
        var cartModal = new bootstrap.Modal(document.getElementById('cartModal'));
        cartModal.show();
    }, 400); // Espera breve para evitar conflicto de animaciones
}

// Cambia este valor si tu sidebar tiene otro ancho
const SIDEBAR_WIDTH = 250; // px

function adjustModalPosition() {
    const body = document.body;
    const modals = document.querySelectorAll('.modal.show .modal-dialog');
    modals.forEach(modal => {
        // Restablece estilos primero
        modal.style.marginLeft = '';
        modal.style.marginRight = '';
        modal.style.left = '';
        modal.style.right = '';
        modal.style.transform = '';

        if (body.classList.contains('sidebar-open') && window.innerWidth > 968) {
            // Calcula el ancho disponible
            const availableWidth = window.innerWidth - SIDEBAR_WIDTH;
            const modalWidth = modal.offsetWidth;
            // Centra la modal en el espacio disponible
            const left = SIDEBAR_WIDTH + (availableWidth - modalWidth) / 2;
            modal.style.position = 'fixed';
            modal.style.left = left + 'px';
            modal.style.right = 'auto';
            modal.style.marginLeft = '0';
            modal.style.marginRight = '0';
            modal.style.transform = 'none';
        } else {
            // Centrado normal
            modal.style.position = '';
            modal.style.left = '';
            modal.style.right = '';
            modal.style.marginLeft = 'auto';
            modal.style.marginRight = 'auto';
            modal.style.transform = 'none';
        }
    });
}

document.addEventListener('DOMContentLoaded', function () {
    // Ajusta al mostrar cualquier modal
    document.querySelectorAll('.modal').forEach(modalEl => {
        modalEl.addEventListener('shown.bs.modal', adjustModalPosition);
    });

    // Ajusta al cambiar el tamaño de la ventana
    window.addEventListener('resize', adjustModalPosition);

});

function updateCartCount() {
    const badge = document.getElementById('cart-count-badge');
    let totalItems = 0;
    Object.values(cart).forEach(item => {
        totalItems += item.quantity;
    });
    if (totalItems > 0) {
        badge.textContent = totalItems;
        badge.style.display = 'inline-block';
    } else {
        badge.style.display = 'none';
    }
}

// Asume que tienes window.processOrderUrl y window.csrfToken definidos en order.html

function verifyStockModal(cart) {
    // Enviar solo para verificar stock, sin registrar cliente ni pedido
    return fetch(window.processOrderUrl, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': window.csrfToken,
            'X-Requested-With': 'XMLHttpRequest'
        },
        body: JSON.stringify({
            cart: JSON.stringify(cart),
            verify_stock: true // Bandera para solo verificar stock
        })
    })
    .then(response => response.json());
}