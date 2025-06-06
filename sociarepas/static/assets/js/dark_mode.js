try {
    if (localStorage.getItem('darkMode') === 'enabled') {
        document.documentElement.classList.add('dark');
        document.body && document.body.classList.add('dark');
    }
} catch (e) { }