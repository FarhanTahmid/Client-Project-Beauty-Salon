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

