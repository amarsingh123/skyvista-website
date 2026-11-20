from django.urls import path
from .views import CaseStudyListView

urlpatterns = [
    path('', CaseStudyListView.as_view(), name='portfolio-list'),
]
