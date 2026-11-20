from django.db import models
from django.utils.text import slugify

CATEGORY_CHOICES = [
    ('software_development', 'Custom Software Development'),
    ('enterprise_solutions', 'Enterprise Solutions'),
    ('cloud_devops', 'Cloud & DevOps'),
    ('ai_automation', 'AI & Automation'),
    ('travel_technology', 'Travel Technology'),
    ('digital_transformation', 'Digital Transformation'),
]

class BlogPost(models.Model):
    title_en = models.CharField(max_length=255)
    title_hi = models.CharField(max_length=255, blank=True)
    slug = models.SlugField(unique=True, blank=True)
    excerpt_en = models.CharField(max_length=300)
    excerpt_hi = models.CharField(max_length=300, blank=True)
    content_en = models.TextField()
    content_hi = models.TextField(blank=True)
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES)
    featured_image = models.ImageField(upload_to='blog/', blank=True, null=True)
    is_published = models.BooleanField(default=False)
    published_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-published_at']

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title_en)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.title_en
