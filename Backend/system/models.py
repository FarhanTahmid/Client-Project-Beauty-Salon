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
    

