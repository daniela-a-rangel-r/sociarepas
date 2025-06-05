import json
from django.shortcuts import render, redirect
from django.db import transaction
from food_filling.models import Food_Type, Food_Filling_Type_Details, Stock
from .models import Client, Order, Order_Details, Payment_Type
import logging
logger = logging.getLogger(__name__)

def order(request):
    food_types = Food_Type.objects.all()
    return render(request, 'order.html', {
        'food_types': food_types
        })

def process_order(request):
    if request.method == 'POST':
        # Obtener datos del cliente desde el formulario
        logger.info("Procesando la orden...")
        client_data = {
            'name': request.POST.get('name'),
            'lastname': request.POST.get('lastname'),
            'address': request.POST.get('address'),
            'phone_number': request.POST.get('phone_number')
        }
        logger.debug(f"Datos del cliente: {client_data}")
        # Obtener el carrito desde el formulario
        cart = json.loads(request.POST.get('cart', '{}'))
        logger.debug(f"Carrito recibido: {cart}")

        # Validar que el carrito no esté vacío
        if not cart:
            logger.warning("El carrito está vacío. Redirigiendo...")
            return redirect('order')  # Redirigir si el carrito está vacío

        try:
            with transaction.atomic():
                # Crear el cliente
                client = Client.objects.create(**client_data)
                logger.info(f"Cliente creado: {client}")

                # Calcular el total de la orden
                total = sum(item['price'] * item['quantity'] for item in cart.values())
                logger.debug(f"Total calculado: {total}")
                # Crear la orden
                order = Order.objects.create(total=total, fk_client=client)
                logger.info(f"Orden creada: {order}")
                # Procesar cada item del carrito
                for title, item in cart.items():
                    food_type_id = item['food_type_id']
                    quantity = item['quantity']
                    logger.debug(f"Procesando item: {title}, cantidad: {quantity}")

                    # Obtener los detalles de relleno para la arepa
                    filling_details = Food_Filling_Type_Details.objects.filter(fk_food_type_id=food_type_id)
                    logger.debug(f"Detalles de relleno obtenidos: {filling_details}")

                    for detail in filling_details:
                        required_quantity = detail.needed_quantity * quantity
                        stock = Stock.objects.filter(fk_food_filling=detail.fk_food_filling).first()
                        logger.debug(f"Stock encontrado: {stock}, cantidad requerida: {required_quantity}")

                        # Validar que haya suficiente stock
                        if stock.quantity < required_quantity:
                            logger.error(f"No hay suficiente stock para {detail.fk_food_filling.name}")
                            raise ValueError(f"No hay suficiente stock para {detail.fk_food_filling.name}")

                        # Descontar del stock
                        stock.quantity -= required_quantity
                        stock.save()
                        logger.info(f"Stock actualizado: {stock}")

                    # Crear los detalles de la orden
                    Order_Details.objects.create(
                        quantity=quantity,
                        fk_food_type_id=food_type_id,
                        fk_payment_type_id=request.POST.get('payment_type'),
                        fk_order=order
                    )
                    logger.info(f"Detalles de la orden creados para {title}")
                # Limpiar el carrito de la sesión
                request.session['cart'] = {}
                logger.info("Carrito limpiado de la sesión.")

                return redirect('order_success')  # Redirigir a una página de éxito
        except Exception as e:
            logger.error(f"Error al procesar la orden: {e}")
            return render(request, 'order.html', {'error': str(e)})

    return redirect('order')