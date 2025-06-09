from django import forms
from .models import Food_Filling, Supplier

class Food_FillingBaseForm(forms.ModelForm):
    
    fk_supplier = forms.ModelChoiceField(
        queryset=Supplier.objects.all(),
        empty_label='Seleccione un proveedor',
        label='Proveedor',
        widget=forms.Select(attrs={'class': 'form-control'})
    )
    initial_quantity = forms.CharField(
        label='Cantidad inicial',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
    )

    class Meta:
        model = Food_Filling
        fields = ['name']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
        }

class Food_FillingCreate(Food_FillingBaseForm):
    pass


class Food_FillingEdit(Food_FillingBaseForm):
    pass


class StockRequestForm(forms.Form):

    fk_supplier = forms.ModelChoiceField(
        queryset=Supplier.objects.all(),
        empty_label='Seleccione un proveedor',
        label='Proveedor',
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    requested_quantity = forms.CharField(
        label='Cantidad a solicitar',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
    )

class SupplierBaseForm(forms.ModelForm):
    
    name = forms.CharField(
        label='Nombre del Proveedor',
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    address = forms.CharField(
        label='Dirección del proveedor',
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    phone_number = forms.CharField(
        label='Número de teléfono del proveedor',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
    )
    rif = forms.CharField(
        label='RIF del proveedor',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
    )

    class Meta:
        model = Supplier
        fields = ['name', 'address', 'phone_number', 'rif']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'address': forms.TextInput(attrs={'class': 'form-control'}),
            'phone_number': forms.TextInput(attrs={'class': 'form-control numeric-only'}),
            'rif': forms.TextInput(attrs={'class': 'form-control numeric-only'})
        }

class SupplierCreate(SupplierBaseForm):
    pass


class SupplierEdit(SupplierBaseForm):
    pass