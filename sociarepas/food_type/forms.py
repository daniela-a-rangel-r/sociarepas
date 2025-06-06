from django import forms
from .models import Food_Type
from food_filling.models import Food_Filling_Type_Details, Food_Filling

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

    fillings = forms.ModelMultipleChoiceField(
        queryset=Food_Filling.objects.all(),
        required=True,  # <-- Cambia a True
        label='Rellenos disponibles',
        widget=forms.SelectMultiple(attrs={
            'class': 'form-control'
        })
    )

    class Meta:
        model = Food_Type
        fields = ['name', 'price', 'fillings']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        # Si estás editando un Food_Type, carga sus rellenos actuales
        if self.instance.pk:
            self.fields['fillings'].initial = Food_Filling.objects.filter(
                food_filling_type_details__fk_food_type=self.instance
            )

    def save(self, commit=True):
        instance = super().save(commit=commit)
        if commit:
            # Elimina los registros previos de la relación
            Food_Filling_Type_Details.objects.filter(fk_food_type=instance).delete()
            # Crea nuevos registros con la cantidad default de relleno
            for filling in self.cleaned_data['fillings']:
                Food_Filling_Type_Details.objects.create(
                    fk_food_type=instance,
                    fk_food_filling=filling,
                    needed_quantity=100  # Usa el nombre correcto del campo
                )
        return instance


class Food_TypeCreate(Food_TypeBaseForm):
    pass

class Food_TypeEdit(Food_TypeBaseForm):
    pass