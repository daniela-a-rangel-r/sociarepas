from django.shortcuts import render, get_object_or_404
from . models import Food_Filling, Stock, Supplier
from . forms import Food_FillingCreate,Food_FillingEdit, StockRequestForm,SupplierCreate,SupplierEdit
from django.http.response import JsonResponse
from django.db.models import Sum,Q
from django.contrib.auth.decorators import login_required

@login_required
def food_filling(request):
    food_filling = Food_Filling.objects.annotate(total_quantity=Sum('stock__quantity'))
    food_filling_create_form = Food_FillingCreate()
    food_filling_edit_form = Food_FillingEdit()
    suppliers = Supplier.objects.all()
    stock_request_form = StockRequestForm()

    return render(request, 'food_filling.html',{
        'food_filling' : food_filling,
        'food_filling_create_form': food_filling_create_form,
        'food_filling_edit_form': food_filling_edit_form,
        'suppliers': suppliers,
        'stock_request_form' : stock_request_form
    })

@login_required
def food_filling_create(request):
    if request.method == "POST":
        food_filling_create_form = Food_FillingCreate(request.POST)
        if food_filling_create_form.is_valid():
            name = food_filling_create_form.cleaned_data['name'].strip()
            if Food_Filling.objects.filter(name__iexact=name).exists():
                return JsonResponse({'status': 'error', 'message': 'Ya existe un relleno con este nombre.'})
            try:
                food_filling = food_filling_create_form.save()

                supplier = food_filling_create_form.cleaned_data.get('fk_supplier')
                initial_quantity = food_filling_create_form.cleaned_data.get('initial_quantity')

                if not supplier or not initial_quantity:
                    return JsonResponse({'status': 'error', 'message': 'Proveedor y cantidad inicial son obligatorios.'})

                Stock.objects.create(
                    fk_food_filling=food_filling,
                    fk_supplier=supplier,
                    quantity=initial_quantity
                )

                return JsonResponse({'status': 'success', 'message': 'El relleno se ha guardado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
    else:
        food_filling_create_form = Food_FillingCreate()
    
    return render(request, 'food_filling.html', {
        'food_filling_create_form': food_filling_create_form
    })

@login_required
def food_filling_edit(request, food_filling_id):
    food_filling = get_object_or_404(Food_Filling, pk=food_filling_id)

    if request.method == "POST":
        food_filling_edit_form = food_filling_edit(request.POST, instance=food_filling)
        if food_filling_edit_form.is_valid():
            name = food_filling_edit_form.cleaned_data['name'].strip()
            if Food_Filling.objects.filter(name__iexact=name).exclude(pk=food_filling.pk).exists():
                return JsonResponse({'status': 'error', 'message': 'Ya existe un producto con este nombre.'})

            try:
                food_filling_edit_form.save()
                return JsonResponse({'status': 'success', 'message': 'El producto se ha actualizado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
        else:
            errors = []
            for field, error_list in food_filling_edit_form.errors.items():
                for error in error_list:
                    errors.append(f'Error en el campo: {error}')
            return JsonResponse({'status': 'error', 'message': ' '.join(errors)})
    
    else:

        food_filling_edit_form = Food_FillingEdit(instance=food_filling)

    return render(request, 'food_filling.html', {
        'food_filling_edit_form': food_filling_edit_form
    })

@login_required
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

@login_required
def stock_request_create(request):
    if request.method == "POST":
        stock_request_form = StockRequestForm(request.POST)
        
        if stock_request_form.is_valid():
            food_filling_id = request.POST.get('fk_food_filling')  # ID del producto
            supplier = stock_request_form.cleaned_data['fk_supplier']  # ID del proveedor
            requested_quantity = stock_request_form.cleaned_data['requested_quantity']  # Cantidad solicitada

            try:
                food_filling = Food_Filling.objects.get(id=food_filling_id)

                # Actualizar el stock existente
                stock, created = Stock.objects.get_or_create(
                    fk_food_filling=food_filling,
                    fk_supplier=supplier,
                    defaults={'quantity': 0}
                )
                stock.quantity += int(requested_quantity)
                stock.save()

                return JsonResponse({'status': 'success', 'message': 'Stock agregado correctamente.'})
            except Food_Filling.DoesNotExist:
                return JsonResponse({'status': 'error', 'message': 'El producto no existe.'}, status=404)
            except Supplier.DoesNotExist:
                return JsonResponse({'status': 'error', 'message': 'El proveedor no existe.'}, status=404)
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'}, status=500)
        else:
            # Si el formulario no es válido, devolver los errores
            return JsonResponse({'status': 'error', 'message': stock_request_form.errors}, status=400)

    return JsonResponse({'status': 'error', 'message': 'Método no permitido.'}, status=405)

#proveedores
@login_required
def supplier(request):
    supplier = Supplier.objects.all()
    supplier_create_form = SupplierCreate()
    supplier_edit_form = SupplierEdit()

    return render(request, 'supplier.html',{
        'supplier' : supplier,
        'supplier_create_form': supplier_create_form,
        'supplier_edit_form': supplier_edit_form,

    })

@login_required
def supplier_create(request):
    if request.method == "POST":
        supplier_create_form = SupplierCreate(request.POST)
        if supplier_create_form.is_valid():
            name = supplier_create_form.cleaned_data['name'].strip()
            rif = supplier_create_form.cleaned_data['rif'].strip()
            if Supplier.objects.filter(Q(name__iexact=name) | Q(rif__iexact=rif)).exists():
                return JsonResponse({
                    'status': 'error',
                    'message': 'Ya existe un proveedor con este nombre o RIF.'
                })
            try:
                supplier_create_form.save()
                return JsonResponse({
                    'status': 'success',
                    'message': 'El proveedor se ha guardado correctamente.'
                })
            except Exception as e:
                return JsonResponse({
                    'status': 'error',
                    'message': f'Error inesperado: {str(e)}'
                })
    else:
        supplier_create_form = SupplierCreate()

    return render(request, 'supplier.html', {
        'supplier_create_form': supplier_create_form
    })

@login_required
def supplier_edit(request, supplier_id):
    supplier = get_object_or_404(Supplier, pk=supplier_id)

    if request.method == "POST":
        supplier_edit_form = SupplierEdit(request.POST, instance=supplier)
        if supplier_edit_form.is_valid():
            name = supplier_edit_form.cleaned_data['name'].strip()
            rif = supplier_edit_form.cleaned_data['rif'].strip()
            if Supplier.objects.filter(Q(name__iexact=name) | Q(rif__iexact=rif)).exists():
                return JsonResponse({
                    'status': 'error',
                    'message': 'Ya existe un proveedor con este nombre o RIF.'
                })

            try:
                supplier_edit_form.save()
                return JsonResponse({'status': 'success', 'message': 'El proveedor se ha actualizado correctamente.'})
            except Exception as e:
                return JsonResponse({'status': 'error', 'message': f'Error inesperado: {str(e)}'})
        else:
            errors = []
            for field, error_list in supplier_edit_form.errors.items():
                for error in error_list:
                    errors.append(f'Error en el campo: {error}')
            return JsonResponse({'status': 'error', 'message': ' '.join(errors)})
    
    else:

        supplier_edit_form = SupplierEdit(instance=supplier)

    return render(request, 'supplier.html', {
        'supplier_edit_form': supplier_edit_form
    })

@login_required
def supplier_delete(request, supplier_id):
    if request.method == 'POST':
        try:
            supplier = Supplier.objects.get(id=supplier_id)
            supplier.delete()
            return JsonResponse({'success': True, 'message': 'Proveedor eliminado correctamente'})
        except Supplier.DoesNotExist:
            return JsonResponse({'success': False, 'message': 'El proveedor no existe'}, status=404)
        except Exception as e:
            return JsonResponse({'success': False, 'message': str(e)}, status=500)
    return JsonResponse({'success': False, 'message': 'Método no permitido'}, status=405)