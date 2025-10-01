(function() {
    try {
        if (localStorage.getItem('sidebarState') === 'hide') {
            document.documentElement.classList.add('sidebar-hide');
        }
    } catch(e){}
})();