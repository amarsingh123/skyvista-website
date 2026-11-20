from django.contrib import admin
from .models import CaseStudy

@admin.register(CaseStudy)
class CaseStudyAdmin(admin.ModelAdmin):
    list_display = ['title', 'client_industry', 'service_category', 'is_published']
    list_filter = ['service_category', 'is_published']
    search_fields = ['title', 'client_industry']
