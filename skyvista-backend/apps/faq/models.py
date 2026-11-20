from django.db import models

CATEGORY_CHOICES = [
    ('general', 'General'),
    ('services', 'Services'),
    ('ai_automation', 'AI & Automation'),
    ('travel_technology', 'Travel Technology'),
    ('process', 'Process & Engagement'),
]

class FAQ(models.Model):
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    question = models.CharField(max_length=300)
    answer = models.TextField()
    order = models.PositiveIntegerField(default=0)
    is_active = models.BooleanField(default=True)

    class Meta:
        ordering = ['category', 'order']

    def __str__(self):
        return self.question
