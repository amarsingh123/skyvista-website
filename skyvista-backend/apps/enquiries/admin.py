from django.contrib import admin
from .models import Enquiry

@admin.register(Enquiry)
class EnquiryAdmin(admin.ModelAdmin):
    list_display = ['full_name', 'email', 'service_interested', 'created_at', 'is_resolved']
    list_filter = ['service_interested', 'is_resolved', 'created_at']
    search_fields = ['full_name', 'email', 'company_name']
    readonly_fields = ['created_at']
