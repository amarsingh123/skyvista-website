from rest_framework import generics
from .models import FAQ
from .serializers import FAQSerializer

class FAQListView(generics.ListAPIView):
    serializer_class = FAQSerializer

    def get_queryset(self):
        return FAQ.objects.filter(is_active=True)
