// Carrusel automático simple
let current = 0;
const slides = document.querySelectorAll('.arepa-slide');
setInterval(() => {
    slides[current].classList.remove('active');
    current = (current + 1) % slides.length;
    slides[current].classList.add('active');
}, 2500);

window.addEventListener('DOMContentLoaded', () => {
    const loginCard = document.querySelector('.card:not(.extra-card)');
    const carouselCard = document.querySelector('.arepa-carousel-card');
    if (loginCard && carouselCard) {
        carouselCard.style.height = loginCard.offsetHeight + 'px';
    }
});