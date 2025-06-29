# Generated by Django 5.2.1 on 2025-06-03 14:57

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('food_filling', '0002_remove_supplier_name_supplier_supplier'),
        ('food_type', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Food_Filling_Type_Details',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fk_food_filling', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='food_filling.food_filling')),
                ('fk_food_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='food_type.food_type')),
            ],
        ),
    ]
