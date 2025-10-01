from django.db import models
from food_type.models import Food_Type

class Payment_Type(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Modo de pago')

    class Meta:
        db_table = 'payment_type'
    
    def __str__(self):
        return self.name
        
class Client(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Nombre del cliente')
    lastname = models.CharField(max_length=45, null=False, verbose_name='Apellido del cliente')
    identity_number = models.IntegerField(null=False, verbose_name='Cédula del cliente')
    address = models.CharField(max_length=45, null=False, verbose_name='Dirección del cliente')
    phone_number = models.CharField(max_length=20, null=False, verbose_name='Número telefónico del cliente')

    class Meta:
        db_table = 'client'
        
class Order(models.Model):
    total = models.IntegerField(null=False, verbose_name='Precio total')
    fk_client = models.ForeignKey(Client, on_delete=models.CASCADE)

    class Meta:
        db_table = 'order'

class Order_Details(models.Model):
    quantity = models.IntegerField(null=False, verbose_name='Cantidad de arepas pedidas')
    fk_food_type = models.ForeignKey(Food_Type, on_delete=models.CASCADE)
    fk_payment_type = models.ForeignKey(Payment_Type, on_delete=models.CASCADE)
    fk_order = models.ForeignKey(Order, on_delete=models.CASCADE)

    class Meta:
        db_table = 'order_details'