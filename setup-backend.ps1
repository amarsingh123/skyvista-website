# =========================================================
# SKYVISTA JOURNEYS LLP - Backend Setup Script (Django)
# PART 1 of 4
# =========================================================

$root = "skyvista-backend"
New-Item -ItemType Directory -Force -Path $root | Out-Null
Set-Location $root

$folders = @(
    "config\settings",
    "apps\enquiries\migrations",
    "apps\blog\migrations",
    "apps\portfolio\migrations",
    "apps\faq\migrations",
    "requirements",
    "media",
    "staticfiles"
)
foreach ($f in $folders) { New-Item -ItemType Directory -Force -Path $f | Out-Null }

function Write-File($path, $content) {
    $dir = Split-Path $path
    if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
    Set-Content -Path $path -Value $content -Encoding UTF8
}


Write-File "manage.py" @'
#!/usr/bin/env python
import os
import sys

def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.development')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()
'@

Write-File ".env.example" @'
SECRET_KEY=change-this-to-a-secure-random-key
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1,api.skyvista.com
DB_NAME=skyvista_db
DB_USER=skyvista_user
DB_PASSWORD=change-this-password
DB_HOST=localhost
DB_PORT=5432
CORS_ALLOWED_ORIGINS=http://localhost:5173,https://skyvista.com,https://www.skyvista.com
EMAIL_HOST=email-smtp.ap-south-1.amazonaws.com
EMAIL_PORT=587
EMAIL_HOST_USER=
EMAIL_HOST_PASSWORD=
DEFAULT_FROM_EMAIL=info@skyvista.com
AWS_STORAGE_BUCKET_NAME=
AWS_S3_REGION_NAME=ap-south-1
'@

Write-File ".gitignore" @'
venv/
__pycache__/
*.pyc
.env
staticfiles/
media/
db.sqlite3
'@

Write-File "README.md" @'
# SKYVISTA JOURNEYS LLP - Backend (Django API)

## Setup
1. python -m venv venv
2. venv\Scripts\activate
3. pip install -r requirements/development.txt
4. copy .env.example .env
5. python manage.py makemigrations
6. python manage.py migrate
7. python manage.py createsuperuser
8. python manage.py runserver

## API Endpoints
- POST /api/enquiries/
- GET  /api/blog/
- GET  /api/blog/<slug>/
- GET  /api/portfolio/?service_category=<category>
- GET  /api/faq/
'@

Write-File "requirements\base.txt" @'
Django==5.0.6
djangorestframework==3.15.1
psycopg2-binary==2.9.9
python-decouple==3.8
django-cors-headers==4.3.1
django-ratelimit==4.1.0
Pillow==10.3.0
django-filter==24.2
'@

Write-File "requirements\development.txt" @'
-r base.txt
'@

Write-File "requirements\production.txt" @'
-r base.txt
gunicorn==22.0.0
whitenoise==6.6.0
boto3==1.34.100
django-storages==1.14.3
'@

Write-File "config\__init__.py" ""
Write-File "config\settings\__init__.py" ""

Write-File "config\urls.py" @'
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/enquiries/', include('apps.enquiries.urls')),
    path('api/blog/', include('apps.blog.urls')),
    path('api/portfolio/', include('apps.portfolio.urls')),
    path('api/faq/', include('apps.faq.urls')),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
'@

Write-File "config\wsgi.py" @'
import os
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.production')
application = get_wsgi_application()
'@

Write-File "config\asgi.py" @'
import os
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.production')
application = get_asgi_application()
'@

Write-Host "PART 1 COMPLETE: Folders, root files, and config/urls/wsgi/asgi created." -ForegroundColor Green

# =========================================================
# PART 2 of 4 - Django Settings Files
# =========================================================

Write-File "config\settings\base.py" @'
from pathlib import Path
from decouple import config

BASE_DIR = Path(__file__).resolve().parent.parent.parent

SECRET_KEY = config('SECRET_KEY')
DEBUG = config('DEBUG', default=False, cast=bool)
ALLOWED_HOSTS = config('ALLOWED_HOSTS', default='').split(',')

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',
    'corsheaders',
    'django_filters',

    'apps.enquiries',
    'apps.blog',
    'apps.portfolio',
    'apps.faq',
]

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'config.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'config.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': config('DB_NAME'),
        'USER': config('DB_USER'),
        'PASSWORD': config('DB_PASSWORD'),
        'HOST': config('DB_HOST'),
        'PORT': config('DB_PORT', default='5432'),
    }
}

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'Asia/Kolkata'
USE_I18N = True
USE_TZ = True

STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'
MEDIA_URL = 'media/'
MEDIA_ROOT = BASE_DIR / 'media'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

REST_FRAMEWORK = {
    'DEFAULT_FILTER_BACKENDS': ['django_filters.rest_framework.DjangoFilterBackend'],
    'DEFAULT_THROTTLE_CLASSES': ['rest_framework.throttling.AnonRateThrottle'],
    'DEFAULT_THROTTLE_RATES': {'anon': '20/minute'},
}

CORS_ALLOWED_ORIGINS = config('CORS_ALLOWED_ORIGINS', default='').split(',')

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = config('EMAIL_HOST', default='')
EMAIL_PORT = config('EMAIL_PORT', default=587, cast=int)
EMAIL_USE_TLS = True
EMAIL_HOST_USER = config('EMAIL_HOST_USER', default='')
EMAIL_HOST_PASSWORD = config('EMAIL_HOST_PASSWORD', default='')
DEFAULT_FROM_EMAIL = config('DEFAULT_FROM_EMAIL', default='info@skyvista.com')
ENQUIRY_NOTIFICATION_EMAIL = 'info@skyvista.com'
'@

Write-File "config\settings\development.py" @'
from .base import *

DEBUG = True
ALLOWED_HOSTS = ['localhost', '127.0.0.1']
CORS_ALLOW_ALL_ORIGINS = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}
'@

Write-File "config\settings\production.py" @'
from .base import *

DEBUG = False
SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
SECURE_HSTS_SECONDS = 31536000
SECURE_HSTS_INCLUDE_SUBDOMAINS = True

STORAGES = {
    "default": {
        "BACKEND": "storages.backends.s3boto3.S3Boto3Storage",
    },
    "staticfiles": {
        "BACKEND": "whitenoise.storage.CompressedManifestStaticFilesStorage",
    },
}

AWS_STORAGE_BUCKET_NAME = config('AWS_STORAGE_BUCKET_NAME', default='')
AWS_S3_REGION_NAME = config('AWS_S3_REGION_NAME', default='ap-south-1')
'@

Write-Host "PART 2 COMPLETE: Django settings (base, development, production) created." -ForegroundColor Green


# =========================================================
# PART 3 of 4 - Enquiries App + Blog App
# =========================================================

Write-File "apps\__init__.py" ""

# ---------- ENQUIRIES APP ----------
Write-File "apps\enquiries\__init__.py" ""
Write-File "apps\enquiries\migrations\__init__.py" ""

Write-File "apps\enquiries\apps.py" @'
from django.apps import AppConfig

class EnquiriesConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.enquiries'
'@

Write-File "apps\enquiries\models.py" @'
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
'@

Write-File "apps\enquiries\serializers.py" @'
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
'@

Write-File "apps\enquiries\views.py" @'
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
'@

Write-File "apps\enquiries\urls.py" @'
from django.urls import path
from .views import EnquiryCreateView

urlpatterns = [
    path('', EnquiryCreateView.as_view(), name='enquiry-create'),
]
'@

Write-File "apps\enquiries\admin.py" @'
from django.contrib import admin
from .models import Enquiry

@admin.register(Enquiry)
class EnquiryAdmin(admin.ModelAdmin):
    list_display = ['full_name', 'email', 'service_interested', 'created_at', 'is_resolved']
    list_filter = ['service_interested', 'is_resolved', 'created_at']
    search_fields = ['full_name', 'email', 'company_name']
    readonly_fields = ['created_at']
'@

# ---------- BLOG APP ----------
Write-File "apps\blog\__init__.py" ""
Write-File "apps\blog\migrations\__init__.py" ""

Write-File "apps\blog\apps.py" @'
from django.apps import AppConfig

class BlogConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.blog'
'@

Write-File "apps\blog\models.py" @'
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
'@

Write-File "apps\blog\serializers.py" @'
from rest_framework import serializers
from .models import BlogPost

class BlogPostListSerializer(serializers.ModelSerializer):
    class Meta:
        model = BlogPost
        fields = ['id', 'title_en', 'title_hi', 'slug', 'excerpt_en', 'excerpt_hi',
                  'category', 'featured_image', 'published_at']

class BlogPostDetailSerializer(serializers.ModelSerializer):
    class Meta:
        model = BlogPost
        fields = ['id', 'title_en', 'title_hi', 'slug', 'excerpt_en', 'excerpt_hi',
                  'content_en', 'content_hi', 'category', 'featured_image', 'published_at']
'@

Write-File "apps\blog\views.py" @'
from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from .models import BlogPost
from .serializers import BlogPostListSerializer, BlogPostDetailSerializer

class BlogPostListView(generics.ListAPIView):
    serializer_class = BlogPostListSerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['category']

    def get_queryset(self):
        return BlogPost.objects.filter(is_published=True)

class BlogPostDetailView(generics.RetrieveAPIView):
    serializer_class = BlogPostDetailSerializer
    lookup_field = 'slug'

    def get_queryset(self):
        return BlogPost.objects.filter(is_published=True)
'@

Write-File "apps\blog\urls.py" @'
from django.urls import path
from .views import BlogPostListView, BlogPostDetailView

urlpatterns = [
    path('', BlogPostListView.as_view(), name='blog-list'),
    path('<slug:slug>/', BlogPostDetailView.as_view(), name='blog-detail'),
]
'@

Write-File "apps\blog\admin.py" @'
from django.contrib import admin
from .models import BlogPost

@admin.register(BlogPost)
class BlogPostAdmin(admin.ModelAdmin):
    list_display = ['title_en', 'category', 'is_published', 'published_at']
    list_filter = ['category', 'is_published']
    search_fields = ['title_en', 'title_hi']
    prepopulated_fields = {'slug': ('title_en',)}
'@

Write-Host "PART 3 COMPLETE: Enquiries app + Blog app created." -ForegroundColor Green

# =========================================================
# PART 4 of 4 - Portfolio App + FAQ App + Completion
# =========================================================

# ---------- PORTFOLIO APP ----------
Write-File "apps\portfolio\__init__.py" ""
Write-File "apps\portfolio\migrations\__init__.py" ""

Write-File "apps\portfolio\apps.py" @'
from django.apps import AppConfig

class PortfolioConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.portfolio'
'@

Write-File "apps\portfolio\models.py" @'
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
'@

Write-File "apps\portfolio\serializers.py" @'
from rest_framework import serializers
from .models import CaseStudy

class CaseStudySerializer(serializers.ModelSerializer):
    class Meta:
        model = CaseStudy
        fields = [
            'id', 'title', 'client_industry', 'summary', 'challenge',
            'solution', 'technology_used', 'outcome', 'service_category', 'thumbnail'
        ]
'@

Write-File "apps\portfolio\views.py" @'
from rest_framework import generics
from django_filters.rest_framework import DjangoFilterBackend
from .models import CaseStudy
from .serializers import CaseStudySerializer

class CaseStudyListView(generics.ListAPIView):
    serializer_class = CaseStudySerializer
    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['service_category']

    def get_queryset(self):
        return CaseStudy.objects.filter(is_published=True)
'@

Write-File "apps\portfolio\urls.py" @'
from django.urls import path
from .views import CaseStudyListView

urlpatterns = [
    path('', CaseStudyListView.as_view(), name='portfolio-list'),
]
'@

Write-File "apps\portfolio\admin.py" @'
from django.contrib import admin
from .models import CaseStudy

@admin.register(CaseStudy)
class CaseStudyAdmin(admin.ModelAdmin):
    list_display = ['title', 'client_industry', 'service_category', 'is_published']
    list_filter = ['service_category', 'is_published']
    search_fields = ['title', 'client_industry']
'@

# ---------- FAQ APP ----------
Write-File "apps\faq\__init__.py" ""
Write-File "apps\faq\migrations\__init__.py" ""

Write-File "apps\faq\apps.py" @'
from django.apps import AppConfig

class FaqConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.faq'
'@

Write-File "apps\faq\models.py" @'
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
'@

Write-File "apps\faq\serializers.py" @'
from rest_framework import serializers
from .models import FAQ

class FAQSerializer(serializers.ModelSerializer):
    class Meta:
        model = FAQ
        fields = ['id', 'category', 'question', 'answer', 'order']
'@

Write-File "apps\faq\views.py" @'
from rest_framework import generics
from .models import FAQ
from .serializers import FAQSerializer

class FAQListView(generics.ListAPIView):
    serializer_class = FAQSerializer

    def get_queryset(self):
        return FAQ.objects.filter(is_active=True)
'@

Write-File "apps\faq\urls.py" @'
from django.urls import path
from .views import FAQListView

urlpatterns = [
    path('', FAQListView.as_view(), name='faq-list'),
]
'@

Write-File "apps\faq\admin.py" @'
from django.contrib import admin
from .models import FAQ

@admin.register(FAQ)
class FAQAdmin(admin.ModelAdmin):
    list_display = ['question', 'category', 'order', 'is_active']
    list_filter = ['category', 'is_active']
    ordering = ['category', 'order']
'@

# ---------- COMPLETION ----------
Set-Location ..

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host " BACKEND SETUP COMPLETE: skyvista-backend/" -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. cd skyvista-backend"
Write-Host "2. python -m venv venv"
Write-Host "3. venv\Scripts\activate"
Write-Host "4. pip install -r requirements\development.txt"
Write-Host "5. copy .env.example .env"
Write-Host "   (then open .env and set SECRET_KEY to any random string)"
Write-Host "6. python manage.py makemigrations"
Write-Host "7. python manage.py migrate"
Write-Host "8. python manage.py createsuperuser"
Write-Host "9. python manage.py runserver"
Write-Host ""
Write-Host "API will be available at: http://localhost:8000/api/"
Write-Host "Admin panel at: http://localhost:8000/admin/"
Write-Host "=========================================================" -ForegroundColor Cyan

