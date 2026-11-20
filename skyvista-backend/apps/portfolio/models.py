from django.db import models

SERVICE_CATEGORY_CHOICES = [
    ('software_development', 'Custom Software Development'),
    ('enterprise_solutions', 'Enterprise Solutions'),
    ('cloud_devops', 'Cloud & DevOps'),
    ('ai_automation', 'AI & Automation'),
    ('travel_technology', 'Travel Technology'),
]

class CaseStudy(models.Model):
    title = models.CharField(max_length=255)
    client_industry = models.CharField(max_length=100)
    summary = models.CharField(max_length=300, help_text="One-line summary for card preview")
    challenge = models.TextField()
    solution = models.TextField()
    technology_used = models.CharField(max_length=255)
    outcome = models.TextField(blank=True)
    service_category = models.CharField(max_length=50, choices=SERVICE_CATEGORY_CHOICES)
    thumbnail = models.ImageField(upload_to='portfolio/', blank=True, null=True)
    is_published = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return self.title
