from django import forms
from .models import Food_Filling

class Food_FillingBaseForm(forms.ModelForm):
    
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
class Food_FillingCreate(Food_FillingBaseForm):
    pass


class Food_FillingEdit(Food_FillingBaseForm):
    pass
