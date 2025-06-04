from django import forms
from .models import Food_Type

class Food_TypeBaseForm(forms.ModelForm):
    name = forms.CharField(
        max_length=45,
        label='Tipo de arepa'
    )
    price = forms.DecimalField(
        max_digits=11,
        decimal_places=2,
        label='Precio de la arepa',
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'min': '0'
        })
    )

    class Meta:
        model = Food_Type
        fields = ['name', 'price']


class Food_TypeCreate(Food_TypeBaseForm):
    pass


class Food_TypeEdit(Food_TypeBaseForm):
    pass
