from django import forms
from .models import Food_Type

class Food_TypeCreate(forms.ModelForm):
    
    class Meta:
        model = Food_Type
        fields = ['name', 'price']
        
    name = forms.CharField(
        max_length=45, 
        label='Tipo de arepa'
        )
    price = forms.CharField(
        max_length=11,
        label='Precio de la arepa',
        widget=forms.TextInput(attrs={'class': 'form-control numeric-only'})
        )