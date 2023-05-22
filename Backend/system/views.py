from django.contrib.auth.models import User, auth
from django.shortcuts import render
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import RegisterUser

# Create your views here.

def systemLanding(request):
    return render(request,'landing.html')

class RegisterUser(APIView):

    def post(self, request):
        data=request.data
        username=data.get('username')
        name=data.get('name')
        email=data.get('email')
        password=data.get('password')

        #check if user is already registered
        if((RegisterUser.objects.filter(username=username).exists()) or RegisterUser.objects.filter(username=username).exists()):
            return Response({
                'error':'Username or email already registered'},
                status=status.HTTP_400_BAD_REQUEST)
        
        # create a new member object 
        try:
            new_user=RegisterUser.objects.create(username=username,name=name, email=email)
            new_user.save()
            signupUser=User.objects.create(username=username,email=email,password=password)
            signupUser.save()
            return Response({'error','User created successfully'},status=status.HTTP_201_CREATED)

        except:
            return Response({'error':'An internal database error occurred'},status=status.HTTP_400_BAD_REQUEST)

class Login(APIView):
    def post(self,request):
        data=request.data
        
        username=data.get('username')
        password=data.get('password')

        user=auth.authenticate(username=username,password=password)
        
        if user is not None:
            auth.login(request,user)
            return Response({'success': 'Logged in successfully','username':username}, status=status.HTTP_202_ACCEPTED)
        else:
            return Response({'error': 'Login unsuccessful'}, status=status.HTTP_401_UNAUTHORIZED)