from django.shortcuts import render
from food_type.models import Food_Type

def order(request):
    food_types = Food_Type.objects.all()
    return render(request, 'order.html', {'food_types': food_types})
