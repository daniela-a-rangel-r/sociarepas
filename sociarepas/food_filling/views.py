from django.shortcuts import render
from . models import Food_Filling
from . forms import Food_FillingCreate
from django.http.response import JsonResponse

def food_filling(request):
    food_filling = Food_Filling.objects.all()
    food_filling_create_form = Food_FillingCreate()
    return render(request, 'food_filling.html',{
        'food_filling' : food_filling,
        'food_filling_create_form': food_filling_create_form
    })

def food_filling_create(request):
    if request.method == "POST":
        food_filling_create_form = Food_FillingCreate(request.POST)
        if food_filling_create_form.is_valid():
            name = food_filling_create_form.cleaned_data['name'].strip()
            # Verifica si ya existe una arepa con el mismo nombre
            if Food_Filling.objects.filter(name__iexact=name).exists():
                return JsonResponse({'status': 'error', 'message': 'Ya existe un relleno con este nombre.'})
            try:
                food_filling_create_form.save()
                return JsonResponse({'status': 'success', 'message': 'El relleno se ha guardado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
    else:
        food_filling_create_form = Food_FillingCreate()
    
    return render(request, 'food_filling.html', {
        'food_filling_create_form': food_filling_create_form
    })

def food_filling_delete(request, food_filling_id):
    if request.method == 'POST':
        try:
            food_type = Food_Filling.objects.get(id=food_filling_id)
            food_type.delete()
            return JsonResponse({'success': True, 'message': 'Relleno eliminado correctamente'})
        except Food_Filling.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'El relleno no existe'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=500)
    return JsonResponse({'success': False, 'message': 'Método no permitido'}, status=405)
