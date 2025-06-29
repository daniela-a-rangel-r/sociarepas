from django.urls import path
from . import views

app_name = 'food_type'
urlpatterns = [
    path("", views.food_type, name="food_type"),
    path('food_type_create/', views.food_type_create, name='food_type_create'),
    path('food_type_edit/<int:food_type_id>/', views.food_type_edit, name='food_type_edit'),
    path('food_type_delete/<int:food_type_id>/', views.food_type_delete, name='food_type_delete'),
    path('food_type_restore/<int:food_type_id>/', views.food_type_restore, name='food_type_restore'),
    path('get_food_type/<int:food_type_id>/', views.get_food_type, name='get_food_type'),
]
