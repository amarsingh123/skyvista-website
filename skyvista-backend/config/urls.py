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
