from rest_framework import generics, status
from rest_framework.response import Response
from django.core.mail import send_mail
from django.conf import settings
from django_ratelimit.decorators import ratelimit
from django.utils.decorators import method_decorator
from .models import Enquiry
from .serializers import EnquirySerializer

@method_decorator(ratelimit(key='ip', rate='5/h', block=True), name='post')
class EnquiryCreateView(generics.CreateAPIView):
    queryset = Enquiry.objects.all()
    serializer_class = EnquirySerializer

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        enquiry = serializer.save()

        try:
            send_mail(
                subject=f"New Enquiry: {enquiry.get_service_interested_display()}",
                message=(
                    f"Name: {enquiry.full_name}\n"
                    f"Email: {enquiry.email}\n"
                    f"Phone: {enquiry.phone}\n"
                    f"Company: {enquiry.company_name}\n"
                    f"Service: {enquiry.get_service_interested_display()}\n\n"
                    f"Message:\n{enquiry.message}"
                ),
                from_email=settings.DEFAULT_FROM_EMAIL,
                recipient_list=[settings.ENQUIRY_NOTIFICATION_EMAIL],
                fail_silently=True,
            )
        except Exception:
            pass

        return Response(
            {"message": "Thank you for reaching out. Our team will get back to you shortly."},
            status=status.HTTP_201_CREATED
        )
