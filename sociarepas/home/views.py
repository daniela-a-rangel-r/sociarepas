from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from food_filling.models import Food_Filling, Supplier
from food_type.models import Food_Type
from order.models import Order
from food_filling.forms import StockRequestForm
from django.db.models import Sum, Count

@login_required
def home(request):
    return render(request, 'home.html')

@login_required
def dashboard(request):
    food_type_total = Food_Type.objects.count()
    food_filling_total = Food_Filling.objects.count()
    order_total = Order.objects.count()
    food_filling = Food_Filling.objects.annotate(total_quantity=Sum('stock__quantity'))
    stock_request_form = StockRequestForm()
    return render(request, 'dashboard.html',{
        'food_filling': food_filling,
        'stock_request_form': stock_request_form,
        'food_type_total' : food_type_total,
        'food_filling_total' : food_filling_total,
        'order_total' : order_total
    })