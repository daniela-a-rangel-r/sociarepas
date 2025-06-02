from django.shortcuts import render

def food_type(request):
    return render(request, 'food_type.html')
