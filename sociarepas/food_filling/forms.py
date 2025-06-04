from django import forms
from .models import Food_Filling

class Food_FillingCreate(forms.ModelForm):
    
    class Meta:
        model = Food_Filling
        fields = ['name', 'quantity']
        
    name = forms.CharField(
        max_length=45, 
        label='Tipo de relleno'
        )
    quantity = forms.CharField(
        max_length=11,
        label='Cantidad de relleno',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
        )