from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from .models import BlogPost
from .serializers import BlogPostListSerializer, BlogPostDetailSerializer

class BlogPostListView(generics.ListAPIView):
    serializer_class = BlogPostListSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['category']

    def get_queryset(self):
        return BlogPost.objects.filter(is_published=True)

class BlogPostDetailView(generics.RetrieveAPIView):
    serializer_class = BlogPostDetailSerializer
    lookup_field = 'slug'

    def get_queryset(self):
        return BlogPost.objects.filter(is_published=True)
