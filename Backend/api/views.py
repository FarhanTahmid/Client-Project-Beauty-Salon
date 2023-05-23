from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.models import User,auth
from system.models import RegisterUser,BeautySalons,GetBookingDetails
from django.contrib.auth.hashers import make_password

# Create your views here.
class RegisterUsers(APIView):

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
            return Response({'success':'User created successfully'},status=status.HTTP_201_CREATED)

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
class GetUserDetails(APIView):
    def get(self,request,username):
        
        userDetails=RegisterUser.objects.get(username=username)
        return Response({'success':"Getting User data",'name':userDetails.name,
                         'email':userDetails.email},status=status.HTTP_200_OK)

class Salons(APIView):
    def get(self,request):
        parlorNameDict={}
        parlorMottoDict={}
        parlorContactNoDict={}
        salonDetails=BeautySalons.objects.all()
        for salon in salonDetails:
            parlorNameDict.update({salon.pk:salon.parlorName})
            parlorMottoDict.update({salon.pk:salon.motto})
            parlorContactNoDict.update({salon.pk:salon.contact_no})
        return Response({'success':"Getting Beauty Salons",'name':parlorNameDict,'motto':parlorMottoDict,'contact':parlorContactNoDict},status=status.HTTP_200_OK)

class BookingRegistration(APIView):
    def post(self,request):
        data=request.data
        username=data.get('username')
        parlorId=data.get('parlorID')
        bookieName=data.get('bookieName')
        bookieEmail=data.get('bookieEmail')
        bookieContactNo=data.get('bookieContactNo')
        bookieAdress=data.get('bokieAdress')
        gender=data.get('gender')
        
        parlorName=data.get('parlorName')
        hairCut=data.get('hairCut')
        hairTreatment=data.get('hairTreatment')
        facial=data.get('facial')
        skinTreatment=data.get('skinTreatment')
        extension=data.get('extension')
        package1=data.get('package1')
        package2=data.get('package2')
        service=data.get('service')
        
        try:
            newBooking=GetBookingDetails.objects.create(
                bookieUsername=RegisterUser.objects.get(username=username),bookieName=bookieName,
                bookieEmail=bookieEmail,bookieContactNo=bookieContactNo,bookieAdress=bookieAdress,gender=gender,
                parlor=BeautySalons.objects.get(pk=parlorId),parlorName=parlorName,
                hairCut=hairCut,hairTreatment=hairTreatment,
                facial=facial,skinTreatment=skinTreatment,
                extension=extension,package1=package1,package2=package2,service=service
                
            )
            newBooking.save()
            return Response({'success':"Booking done successfully"},status=status.HTTP_201_CREATED)
        except:
            return Response({'error':'An internal database error occurred'},status=status.HTTP_400_BAD_REQUEST)          
        
             
        
        
        