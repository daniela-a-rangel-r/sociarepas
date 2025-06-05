from django.db import models
from food_type.models import Food_Type

SUPPLIER_CHOICES = [
    (1, 'Empresas Polar'),
    (2, 'Granos Pantera'),
    (3, 'Alimentos Mary'),
    (4, 'Hiper Verduras de Aragua C.A'),
    (5, 'Embutidos Frío Carnes')
]

class Food_Filling(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Tipo de relleno')

    class Meta:
        db_table = 'food_filling'
        
    def __str__(self):
        return self.name

class Food_Filling_Type_Details(models.Model):
    fk_food_filling = models.ForeignKey(Food_Filling, on_delete=models.CASCADE)
    fk_food_type = models.ForeignKey(Food_Type, on_delete=models.CASCADE)
    needed_quantity = models.IntegerField(null=False, default="100", verbose_name='Cantidad requerida de relleno')

        
class Supplier(models.Model):
    supplier = models.IntegerField(null=True, choices=SUPPLIER_CHOICES, verbose_name='Proveedor')

    class Meta:
        db_table = 'supplier'

class Stock(models.Model):
    quantity = models.IntegerField(null=False, verbose_name='Cantidad de relleno disponible')
    fk_food_filling = models.ForeignKey(Food_Filling, on_delete=models.CASCADE)
    fk_supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)

    class Meta:
        db_table = 'stock'