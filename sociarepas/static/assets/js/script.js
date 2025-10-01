const allSideMenu = document.querySelectorAll('#sidebar .side-menu.top li a');

allSideMenu.forEach(item => {
	const li = item.parentElement;

	item.addEventListener('click', function () {
		// Quita 'active' y 'menu-animate' de todos los li principales
		allSideMenu.forEach(i => {
			i.parentElement.classList.remove('active', 'menu-animate');
		});
		// Si es dropdown-toggle (Caja), también aplica la animación
		if (item.classList.contains('dropdown-toggle')) {
			li.classList.add('active', 'menu-animate');
			setTimeout(() => li.classList.remove('menu-animate'), 400);
		} else {
			li.classList.add('active', 'menu-animate');
			setTimeout(() => li.classList.remove('menu-animate'), 400);
		}
	});
});



// TOGGLE SIDEBAR
const menuBar = document.querySelector('#content nav .bx.bx-menu');
const sidebar = document.getElementById('sidebar');

menuBar.addEventListener('click', function () {
    sidebar.classList.toggle('hide');
    if (sidebar.classList.contains('hide')) {
        localStorage.setItem('sidebarState', 'hide');
        document.documentElement.classList.add('sidebar-hide');
    } else {
        localStorage.setItem('sidebarState', 'show');
        document.documentElement.classList.remove('sidebar-hide');
    }
});


// Mantener activo el menú según la URL y animar el cambio
function setActiveMenu() {
	const currentUrl = window.location.pathname;
	allSideMenu.forEach(item => {
		const li = item.parentElement;
		li.classList.remove('active', 'menu-animate');
		// Solo activa si la URL coincide y NO es el menú de Caja (dropdown)
		if (
			item.href &&
			item.href.includes(currentUrl) &&
			!item.classList.contains('dropdown-toggle')
		) {
			li.classList.add('active', 'menu-animate');
			setTimeout(() => li.classList.remove('menu-animate'), 400);
		}
	});
}
window.addEventListener('DOMContentLoaded', setActiveMenu);



const searchButton = document.querySelector('#content nav form .form-input button');
const searchButtonIcon = document.querySelector('#content nav form .form-input button .bx');
const searchForm = document.querySelector('#content nav form');

searchButton.addEventListener('click', function (e) {
	if (window.innerWidth < 576) {
		e.preventDefault();
		searchForm.classList.toggle('show');
		if (searchForm.classList.contains('show')) {
			searchButtonIcon.classList.replace('bx-search', 'bx-x');
		} else {
			searchButtonIcon.classList.replace('bx-x', 'bx-search');
		}
	}
})





if (window.innerWidth < 768) {
	sidebar.classList.add('hide');
} else if (window.innerWidth > 576) {
	searchButtonIcon.classList.replace('bx-x', 'bx-search');
	searchForm.classList.remove('show');
}


window.addEventListener('resize', function () {
	if (this.innerWidth > 576) {
		searchButtonIcon.classList.replace('bx-x', 'bx-search');
		searchForm.classList.remove('show');
	}
})


const switchMode = document.getElementById('switch-mode');

// Al cargar la página, verifica si el modo oscuro estaba activado
if (localStorage.getItem('darkMode') === 'enabled') {
	document.documentElement.classList.add('dark');
	document.body.classList.add('dark');
	switchMode.checked = true;
}

switchMode.addEventListener('change', function () {
	if (this.checked) {
		document.documentElement.classList.add('dark');
		document.body.classList.add('dark');
		localStorage.setItem('darkMode', 'enabled');
	} else {
		document.documentElement.classList.remove('dark');
		document.body.classList.remove('dark');
		localStorage.setItem('darkMode', 'disabled');
	}
});


document.addEventListener('DOMContentLoaded', function () {
    const sidebarState = localStorage.getItem('sidebarState');
    if (sidebarState === 'hide') {
        sidebar.classList.add('hide');
        document.documentElement.classList.add('sidebar-hide');
    } else {
        sidebar.classList.remove('hide');
        document.documentElement.classList.remove('sidebar-hide');
    }
	
	// const sidebar = document.getElementById('sidebar');
	// Cuando se muestra una modal
	document.addEventListener('show.bs.modal', function () {
		sidebar.classList.add('modal-sidebar-backdrop');
	});
	// Cuando se oculta una modal
	document.addEventListener('hidden.bs.modal', function () {
		sidebar.classList.remove('modal-sidebar-backdrop');
	});
});

// ...existing code...

function forceSidebarHideOnMobile() {
    const sidebar = document.getElementById('sidebar');
    const menuBar = document.querySelector('#content nav .bx.bx-menu');
    if (window.innerWidth <= 768) {
        sidebar.classList.add('hide');
        document.documentElement.classList.add('sidebar-hide');
        // Deshabilita el botón de menú
        if (menuBar) {
            menuBar.style.pointerEvents = 'none';
            menuBar.style.opacity = '0.5';
        }
    } else {
        menuBar.style.pointerEvents = '';
        menuBar.style.opacity = '';
    }
}

// Ejecuta al cargar y al redimensionar
window.addEventListener('DOMContentLoaded', forceSidebarHideOnMobile);
window.addEventListener('resize', forceSidebarHideOnMobile);

// ...existing code...