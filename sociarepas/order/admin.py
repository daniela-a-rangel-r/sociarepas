from django.contrib import admin
from .models import Payment_Type, Client, Order, Order_Details

admin.site.register(Payment_Type)
admin.site.register(Client)
admin.site.register(Order)
admin.site.register(Order_Details)