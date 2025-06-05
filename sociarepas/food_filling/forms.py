from django import forms
from .models import Food_Filling

SUPPLIER_CHOICES = [
    (1, 'Empresas Polar'),
    (2, 'Granos Pantera'),
    (3, 'Alimentos Mary'),
    (4, 'Hiper Verduras de Aragua C.A'),
    (5, 'Embutidos Frío Carnes')
]

class Food_FillingBaseForm(forms.ModelForm):
    
    fk_supplier = forms.ChoiceField(
        choices=[(None, 'Seleccione un proveedor')] + SUPPLIER_CHOICES,
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

    fk_supplier = forms.ChoiceField(
        choices=[(None, 'Seleccione un proveedor')] + SUPPLIER_CHOICES,
        label='Proveedor',
        widget=forms.Select(attrs={'class': 'form-control'})
    )

    requested_quantity = forms.CharField(
        label='Cantidad a solicitar',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
    )