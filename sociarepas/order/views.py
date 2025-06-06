import json
from django.shortcuts import render
from django.db import transaction
from django.http import JsonResponse
from food_filling.models import Food_Type, Food_Filling_Type_Details, Stock
from .models import Client, Order, Order_Details, Payment_Type

def order(request):
    food_types = Food_Type.objects.all()
    return render(request, 'order.html', {
        'food_types': food_types
        })

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