from django.db import models

class Food_Type(models.Model):
    name = models.CharField(max_length=45, null=False, verbose_name='Tipo de arepa')
    price = models.IntegerField(null=False, verbose_name='Precio de la arepa')

    class Meta:
        db_table = 'food_type'