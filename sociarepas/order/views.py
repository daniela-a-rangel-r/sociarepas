import json
from django.shortcuts import render
from django.db import transaction
from django.http import JsonResponse
from food_filling.models import Food_Type, Food_Filling_Type_Details, Stock
from .models import Client, Order, Order_Details, Payment_Type
from django.contrib.auth.decorators import login_required
from django.db.models import Sum, F, Q

@login_required
def order(request):
    food_types = []
    for food_type in Food_Type.objects.all():
        fillings = Food_Filling_Type_Details.objects.filter(fk_food_type=food_type)
        can_make = True
        for filling in fillings:
            stock = Stock.objects.filter(fk_food_filling=filling.fk_food_filling).aggregate(total=Sum('quantity'))['total'] or 0
            if stock < filling.needed_quantity:
                can_make = False
                break
        if can_make:
            food_types.append(food_type)
    return render(request, 'order.html', {
        'food_types': food_types
    })

@login_required
def bill(request):
    orders = Order.objects.select_related('fk_client').prefetch_related('order_details_set__fk_payment_type')
    orders_data = []
    for order in orders:
        details = order.order_details_set.all()
        total_quantity = sum(detail.quantity for detail in details)
        if details:
            payment_type_obj = details[0].fk_payment_type
            payment_type_display = payment_type_obj.get_payment_type_display() if payment_type_obj else ''
        else:
            payment_type_display = ''
        orders_data.append({
            'order': order,
            'total_quantity': total_quantity,
            'payment_type': payment_type_display,
        })
    return render(request, 'bill.html', {
        'orders_data': orders_data
    })
    
@login_required
@transaction.atomic
def process_order(request):
    if request.method == "POST":
        data = request.POST
        cart = json.loads(data.get('cart', '{}'))
        payment_type_id = int(data.get('payment_type', 1))
        
        # 1. Registrar cliente
        client = Client.objects.create(
            name=data.get('name'),
            lastname=data.get('lastname'),
            address=data.get('address'),
            phone_number=data.get('phone_number')
        )

        # 2. Calcular total
        total = sum(item['price'] * item['quantity'] for item in cart.values())

        # 3. Registrar orden
        order = Order.objects.create(
            total=total,
            fk_client=client
        )

        # 4. Procesar cada arepa del carrito
        for food_type_name, item in cart.items():
            # Buscar el Food_Type correspondiente
            try:
                food_type = Food_Type.objects.get(name=food_type_name)
            except Food_Type.DoesNotExist:
                continue

            # Registrar detalles de la orden
            Order_Details.objects.create(
                quantity=item['quantity'],
                fk_food_type=food_type,
                fk_payment_type_id=payment_type_id,
                fk_order=order
            )

            # Descontar stock de cada relleno asociado
            food_fillings = Food_Filling_Type_Details.objects.filter(fk_food_type=food_type)
            for food_filling in food_fillings:
                total_quantity = food_filling.needed_quantity * item['quantity']
                # Buscar stock disponible
                stocks = Stock.objects.filter(fk_food_filling=food_filling.fk_food_filling).order_by('id')
                for stock in stocks:
                    if stock.quantity >= total_quantity:
                        stock.quantity -= total_quantity
                        stock.save()
                        break
                    else:
                        total_quantity -= stock.quantity
                        stock.quantity = 0
                        stock.save()
                        # Si cantidad_total > 0, sigue descontando en el siguiente stock

        return JsonResponse({'success': True, 'message': 'Pedido procesado correctamente'})
    return JsonResponse({'success': False, 'message': 'Método no permitido'}, status=405)