from django.shortcuts import render

# Create your views here.

def systemLanding(request):
    return render(request,'landing.html')