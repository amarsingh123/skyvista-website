from rest_framework import serializers
from .models import Enquiry

class EnquirySerializer(serializers.ModelSerializer):
    class Meta:
        model = Enquiry
        fields = [
            'id', 'full_name', 'email', 'phone',
            'company_name', 'service_interested', 'message', 'created_at'
        ]
        read_only_fields = ['id', 'created_at']

    def validate_email(self, value):
        if not value or '@' not in value:
            raise serializers.ValidationError("A valid email address is required.")
        return value

    def validate_message(self, value):
        if len(value.strip()) < 10:
            raise serializers.ValidationError("Please provide more detail (minimum 10 characters).")
        return value
