from django.shortcuts import render
from django.contrib.auth import authenticate, login as auth_login
from django.http import JsonResponse
from django.contrib.auth import logout
from django.shortcuts import redirect
def login(request):
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            auth_login(request, user)
            return JsonResponse({'status': 'success', 'message': 'Inicio de sesión exitoso.', 'redirect_url': '/home/dashboard/'})
        else:
            return JsonResponse({'status': 'error', 'message': 'Usuario o contraseña incorrectos.'})
    return render(request, 'login.html')

def log_out(request):
    logout(request)
    return redirect('/login/')