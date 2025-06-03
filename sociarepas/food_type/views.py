from django.shortcuts import render
from . models import Food_Type

def food_type(request):
    food_type = Food_Type.objects.all()
    return render(request, 'food_type.html', {
        'food_type' : food_type
    })
