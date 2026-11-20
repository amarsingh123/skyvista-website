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
