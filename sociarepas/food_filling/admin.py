from django.contrib import admin
from .models import Food_Filling, Food_Filling_Type_Details, Supplier, Stock

admin.site.register(Food_Filling)
admin.site.register(Food_Filling_Type_Details)
admin.site.register(Supplier)
admin.site.register(Stock)