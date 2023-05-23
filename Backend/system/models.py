from django.db import models

# Create your models here.

class RegisterUser(models.Model):
    username = models.CharField(max_length=50,null=False,blank=True,primary_key=True)
    name=models.CharField(max_length=150,null=False,blank=True)
    email=models.EmailField(max_length=50,null=False,blank=False)
    
    class Meta:
        verbose_name = "Registered User"
    def __str__(self) -> str:
        return self.username

class BeautySalons(models.Model):
    parlorName=models.CharField(max_length=50,null=False,blank=False)
    motto=models.CharField(max_length=50,null=True,blank=True)
    contact_no=models.CharField(max_length=50,null=True,blank=True)
    
    class Meta:
        verbose_name="Registered Salons"
        
    def __str__(self):
        return self.parlorName

class GetBookingDetails(models.Model):
    #bookie details
    bookieUsername=models.ForeignKey(RegisterUser,null=False,blank=False,on_delete=models.CASCADE)
    bookieName=models.CharField(max_length=50,null=True,blank=True)
    bookieEmail=models.CharField(max_length=50,null=True,blank=True)
    bookieContactNo=models.CharField(max_length=20,null=True,blank=True)
    bookieAdress=models.CharField(max_length=100,null=True,blank=True)
    gender=models.CharField(max_length=50,null=True,blank=True)
    
    #parlor details
    parlor=models.ForeignKey(BeautySalons,null=False,blank=False,on_delete=models.CASCADE)
    parlorName=models.CharField(max_length=50,null=True,blank=True)
    hairCut=models.CharField(max_length=50,null=True,blank=True)
    hairTreatment=models.CharField(max_length=50,null=True,blank=True)
    facial=models.CharField(max_length=50,null=True,blank=True)
    skinTreatment=models.CharField(max_length=50,null=True,blank=True)
    extension=models.CharField(max_length=50,null=True,blank=True)
    package1=models.CharField(max_length=50,null=True,blank=True)
    package2=models.CharField(max_length=50,null=True,blank=True)
    service=models.CharField(max_length=50,null=True,blank=True)
    
    
    class Meta:
        verbose_name="Salon Booking Details"
    def __str__(self) -> str:
        return self.pk