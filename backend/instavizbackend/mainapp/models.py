from django.db import models

class InstagramData(models.Model):
    username = models.CharField(max_length=255, unique=True)
    followers = models.PositiveIntegerField(default=0)
    following = models.PositiveIntegerField(default=0)
    comments = models.PositiveIntegerField(default=0)
    likes = models.PositiveIntegerField(default=0)