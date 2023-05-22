from django.urls import path

from . import views
from .views import RegisterUser

app_name='system'

urlpatterns = [
    path('',views.systemLanding,name='landing'),
    path('signup/', RegisterUser.as_view(), name='signup'),
]
