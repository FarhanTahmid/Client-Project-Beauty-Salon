from django.contrib import admin

from .models import RegisterUser,BeautySalons,GetBookingDetails

# Register your models here.

@admin.register(RegisterUser)
class RegisterUser(admin.ModelAdmin):
    list_display=[
        'username',
        'name',
        'email',
    ]

@admin.register(BeautySalons)
class BeautySalons(admin.ModelAdmin):
    list_display=[
        'parlorName',
        'contact_no'
    ]
@admin.register(GetBookingDetails)
class BookingDetails(admin.ModelAdmin):
    list_display=[
        'bookieUsername',
        'bookieName',
        'bookieEmail',
        'parlor',
        'gender'
        
        
    ]