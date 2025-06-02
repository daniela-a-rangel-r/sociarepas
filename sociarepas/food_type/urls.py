from django.urls import path
from . import views

app_name = 'food_type'
urlpatterns = [
    path("", views.food_type, name="food_type"), 
]
