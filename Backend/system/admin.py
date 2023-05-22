from django.contrib import admin

from .models import RegisterUser

# Register your models here.

@admin.register(RegisterUser)
class RegisterUser(admin.ModelAdmin):
    list_display=[
        'username',
        'name',
        'email',
    ]
