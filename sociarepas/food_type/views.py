from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from . models import Food_Type
from food_filling.models import Food_Filling_Type_Details
from . forms import Food_TypeCreate, Food_TypeEdit
from django.http.response import JsonResponse
from django.contrib.auth.decorators import login_required

@login_required
def get_food_type(request, food_type_id):
    if request.method == 'GET' and request.headers.get('X-Requested-With') == 'XMLHttpRequest':
        try:
            food_type = Food_Type.objects.get(id=food_type_id)
            fillings_details = Food_Filling_Type_Details.objects.filter(fk_food_type=food_type)
            fillings = []
            quantities = {}
            for detail in fillings_details:
                fillings.append(detail.fk_food_filling_id)
                quantities[str(detail.fk_food_filling_id)] = detail.needed_quantity
            return JsonResponse({
                'status': 'success',
                'data': {
                    'id': food_type.id,
                    'name': food_type.name,
                    'price': str(food_type.price),
                    'fillings': fillings,
                    'quantities': quantities,
                }
            })
        except Food_Type.DoesNotExist:
            return JsonResponse({'status': 'error', 'message': 'Arepa no encontrada.'})

@login_required
def food_type(request):
    food_type = Food_Type.objects.all()
    food_type_create_form = Food_TypeCreate()
    food_type_edit_form = Food_TypeEdit()
    return render(request, 'food_type.html', {
        'food_type' : food_type,
        'food_type_create_form': food_type_create_form,
        'food_type_edit_form': food_type_edit_form
    })

@login_required
def food_type_create(request):
    if request.method == "POST":
        food_type_create_form = Food_TypeCreate(request.POST)
        if food_type_create_form.is_valid():
            name = food_type_create_form.cleaned_data['name'].strip()
            # Verifica si ya existe una arepa con el mismo nombre
            if Food_Type.objects.filter(name__iexact=name).exists():
                return JsonResponse({'status': 'error', 'message': 'Ya existe una arepa con este nombre.'})
            try:
                food_type_create_form.save()
                return JsonResponse({'status': 'success', 'message': 'La arepa se ha guardado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
    else:
        food_type_create_form = Food_TypeCreate()
    
    return render(request, 'food_type.html', {
        'food_type_create_form': food_type_create_form
    })

@login_required
def food_type_edit(request, food_type_id):
    food_type = get_object_or_404(Food_Type, pk=food_type_id)

    if request.method == "POST":
        food_type_edit_form = Food_TypeEdit(request.POST, instance=food_type)
        if food_type_edit_form.is_valid():
            name = food_type_edit_form.cleaned_data['name'].strip()
            if Food_Type.objects.filter(name__iexact=name).exclude(pk=food_type.pk).exists():
                return JsonResponse({'status': 'error', 'message': 'Ya existe una arepa con este nombre.'})

            try:
                food_type_edit_form.save()
                return JsonResponse({'status': 'success', 'message': 'La arepa se ha actualizado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
        else:
            errors = []
            for field, error_list in food_type_edit_form.errors.items():
                for error in error_list:
                    errors.append(f'Error en el campo: {error}')
            return JsonResponse({'status': 'error', 'message': ' '.join(errors)})
    
    else:

        food_type_edit_form = Food_TypeEdit(instance=food_type)

    return render(request, 'food_type.html', {
        'food_type_edit_form': food_type_edit_form
    })

@login_required
def food_type_delete(request, food_type_id):
    if request.method == 'POST':
        try:
            food_type = Food_Type.objects.get(id=food_type_id)
            food_type.is_active = False
            food_type.save()
            return JsonResponse({'success': True, 'message': 'Arepa ocultada correctamente'})
        except Food_Type.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'La arepa no existe'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=500)
    return JsonResponse({'success': False, 'message': 'Método no permitido'}, status=405)

@login_required
def food_type_restore(request, food_type_id):
    if request.method == 'POST':
        try:
            food_type = Food_Type.objects.get(id=food_type_id)
            food_type.is_active = True
            food_type.save()
            return JsonResponse({'success': True, 'message': 'Arepa restaurada correctamente'})
        except Food_Type.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'La arepa no existe'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=500)
    return JsonResponse({'success': False, 'message': 'Método no permitido'}, status=405)