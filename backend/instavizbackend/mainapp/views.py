from rest_framework import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from .models import InstagramData

class InstagramDataView(APIView):
    def get(self, request, username):
        # Replace 'ACCESS_TOKEN' with your Instagram Graph API access token
        access_token = 'ACCESS_TOKEN'
        # Fetch followers count
        followers_url = f"https://graph.instagram.com/{username}?fields=followers_count&access_token={access_token}"
        followers_response = requests.get(followers_url)
        followers_count = followers_response.json().get('followers_count', 0)
        
        # Fetch following count
        following_url = f"https://graph.instagram.com/{username}?fields=follows_count&access_token={access_token}"
        following_response = requests.get(following_url)
        following_count = following_response.json().get('follows_count', 0)
        
        # Fetch recent media data
        media_url = f"https://graph.instagram.com/{username}/media?fields=comments_count,like_count&access_token={access_token}"
        media_response = requests.get(media_url)
        media_data = media_response.json().get('data', [])
        
        # Aggregate comments count and like count from recent media
        comments_count = 0
        likes_count = 0
        for media in media_data:
            comments_count += media.get('comments_count', 0)
            likes_count += media.get('like_count', 0)
        
        # Prepare response data
        response_data = {
            'username': username,
            'followers': followers_count,
            'following': following_count,
            'comments': comments_count,
            'likes': likes_count
        }
        
        # Check if data already exists in the database for the given username
        try:
            existing_data = InstagramData.objects.get(username=username)
            
            # Calculate differences in stats
            followers_diff = followers_count - existing_data.followers
            following_diff = following_count - existing_data.following
            comments_diff = comments_count - existing_data.comments
            likes_diff = likes_count - existing_data.likes
            
            # Add differences to the response data
            response_data['followers_diff'] = followers_diff
            response_data['following_diff'] = following_diff
            response_data['comments_diff'] = comments_diff
            response_data['likes_diff'] = likes_diff
        except InstagramData.DoesNotExist:
            # No previous data exists, skip calculating differences
            pass
        
        # Store the new data in the database
        InstagramData.objects.update_or_create(
            username=username,
            defaults={
                'followers': followers_count,
                'following': following_count,
                'comments': comments_count,
                'likes': likes_count
            }
        )
        
        return Response(response_data)
