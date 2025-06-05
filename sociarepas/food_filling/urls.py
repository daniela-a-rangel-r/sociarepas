from django.urls import path
from . import views

app_name = 'food_filling'
urlpatterns = [
    path("", views.food_filling, name="food_filling"),
    path('food_filling_create/', views.food_filling_create, name='food_filling_create'),
    path('food_filling_edit/<int:food_filling_id>/', views.food_filling_edit, name='food_filling_edit'),
    path('food_filling_delete/<int:food_filling_id>/', views.food_filling_delete, name='food_filling_delete'),
    path('stock_request_create/', views.stock_request_create, name='stock_request_create'),
]
