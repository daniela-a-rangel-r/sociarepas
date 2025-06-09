from django.db import models
from food_type.models import Food_Type

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
    name = models.CharField(max_length=45, null=False, verbose_name='Nombre de la empresa')
    address = models.CharField(max_length=45, null=False, verbose_name='Dirección de la empresa')
    phone_number = models.CharField(max_length=20, null=False, verbose_name='Número telefónico de la empresa')
    rif = models.CharField(max_length=45, null=False, verbose_name='RIF de la empresa')

    class Meta:
        db_table = 'supplier'
    
    def __str__(self):
        return self.name

class Stock(models.Model):
    quantity = models.IntegerField(null=False, verbose_name='Cantidad de relleno disponible')
    fk_food_filling = models.ForeignKey(Food_Filling, on_delete=models.CASCADE)
    fk_supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)

    class Meta:
        db_table = 'stock'