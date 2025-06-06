from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from food_filling.models import Food_Filling, Supplier
from food_filling.forms import StockRequestForm
from django.db.models import Sum

@login_required
def home(request):
    return render(request, 'home.html')

@login_required
def dashboard(request):
    food_filling = Food_Filling.objects.annotate(total_quantity=Sum('stock__quantity'))
    stock_request_form = StockRequestForm()
    return render(request, 'dashboard.html',{
        'food_filling': food_filling,
        'stock_request_form': stock_request_form,
    })