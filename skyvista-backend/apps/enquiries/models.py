from django.db import models

SERVICE_CHOICES = [
    ('software_development', 'Custom Software Development'),
    ('enterprise_solutions', 'Enterprise Solutions'),
    ('cloud_devops', 'Cloud & DevOps'),
    ('ai_automation', 'AI & Automation'),
    ('it_consulting', 'IT Consulting & Support'),
    ('travel_technology', 'Travel Technology'),
    ('other', 'Other / Not Sure'),
]

class Enquiry(models.Model):
    full_name = models.CharField(max_length=255)
    email = models.EmailField()
    phone = models.CharField(max_length=20, blank=True)
    company_name = models.CharField(max_length=255, blank=True)
    service_interested = models.CharField(max_length=50, choices=SERVICE_CHOICES)
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    is_resolved = models.BooleanField(default=False)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.full_name} - {self.service_interested}"
