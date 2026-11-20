from rest_framework import serializers
from .models import BlogPost

class BlogPostListSerializer(serializers.ModelSerializer):
    class Meta:
        model = BlogPost
        fields = ['id', 'title_en', 'title_hi', 'slug', 'excerpt_en', 'excerpt_hi',
                  'category', 'featured_image', 'published_at']

class BlogPostDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = BlogPost
        fields = ['id', 'title_en', 'title_hi', 'slug', 'excerpt_en', 'excerpt_hi',
                  'content_en', 'content_hi', 'category', 'featured_image', 'published_at']
