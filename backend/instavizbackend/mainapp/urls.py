from django.urls import path
from .views import InstagramDataView

urlpatterns = [
    path('instagram-data/<str:username>/', InstagramDataView.as_view(), name='instagram_data'),
]