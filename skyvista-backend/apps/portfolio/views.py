from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from .models import CaseStudy
from .serializers import CaseStudySerializer

class CaseStudyListView(generics.ListAPIView):
    serializer_class = CaseStudySerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['service_category']

    def get_queryset(self):
        return CaseStudy.objects.filter(is_published=True)
