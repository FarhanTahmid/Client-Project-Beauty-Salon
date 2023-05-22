from django.urls import path
from api.views import RegisterUser


app_name='api'

urlpatterns = [
    path('signup', RegisterUser.as_view(), name='signup'),
]
