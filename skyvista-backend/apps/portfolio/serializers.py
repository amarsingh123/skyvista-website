from rest_framework import serializers
from .models import CaseStudy

class CaseStudySerializer(serializers.ModelSerializer):
    class Meta:
        model = CaseStudy
        fields = [
            'id', 'title', 'client_industry', 'summary', 'challenge',
            'solution', 'technology_used', 'outcome', 'service_category', 'thumbnail'
        ]
