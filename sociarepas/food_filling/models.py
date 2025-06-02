from django.db import models
from food_type.models import Food_Type

class Food_Filling(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Tipo de relleno')
    fk_food_type = models.ForeignKey(Food_Type, on_delete=models.CASCADE)

    class Meta:
        db_table = 'food_filling'
        
class Supplier(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Proveedor')

    class Meta:
        db_table = 'supplier'

class Stock(models.Model):
    quantity = models.IntegerField(null=False, verbose_name='Cantidad de relleno disponible')
    fk_food_type = models.ForeignKey(Food_Type, on_delete=models.CASCADE)
    fk_supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)

    class Meta:
        db_table = 'stock'