from django.urls import path
from . import views
from food_filling import views as food_filling_views
from food_type import views as food_type_views
from order import views as order_views

app_name = 'home'
urlpatterns = [
    path("", views.home, name="home"),
    path("dashboard/", views.dashboard, name="dashboard"),
    path("food_filling/", food_filling_views.food_filling, name="food_filling"),
    path("food_type/", food_type_views.food_type, name="food_type"),
    path("order/", order_views.order, name="order"),
    path("bill/", order_views.bill, name="bill"),
]
