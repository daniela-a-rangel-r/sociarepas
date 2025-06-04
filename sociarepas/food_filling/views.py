from django.shortcuts import render
from . models import Food_Filling

def food_filling(request):
    food_filling = Food_Filling.objects.all()
    return render(request, 'food_filling.html',{
        'food_filling' : food_filling
    })
