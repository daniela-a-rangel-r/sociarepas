from django.urls import path
from . import views

app_name = 'food_filling'
urlpatterns = [
    path("", views.food_filling, name="food_filling"), 
]
