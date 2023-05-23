from django.urls import path
from api.views import RegisterUsers,Login,Salons


app_name='api'

urlpatterns = [
    path('signup', RegisterUsers.as_view(), name='signup'),
    path('login',Login.as_view(),name='login'),
    path('beautysalons',Salons.as_view(),name="beauty_salons")
]
