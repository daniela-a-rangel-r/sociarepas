from django.shortcuts import render

def food_filling(request):
    return render(request, 'food_filling.html')
