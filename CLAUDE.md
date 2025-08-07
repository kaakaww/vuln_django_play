# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **deliberately vulnerable Django application** based on the Django Polls tutorial. It is designed for security testing and demonstrates common web vulnerabilities including XSS and SQL injection. The application intentionally disables Django's built-in security protections.

**SECURITY WARNING**: This codebase contains intentional vulnerabilities and should NEVER be deployed to production or exposed to the public internet.

## Development Commands

### Docker Development (Recommended)

**All-in-One Container:**
```bash
docker-compose up --build
```

**Microservice Architecture:**
```bash
# Full setup with migrations, admin user, and seed data
./scripts/build-and-run.sh

# Build and run with security scanning
./scripts/build-and-scan.sh
```

**Manual Microservice Setup:**
```bash
docker-compose -f docker-micro.yml build
docker-compose -f docker-micro.yml up --detach
./scripts/migrations.sh
```

### Local Development

**Install Dependencies:**
```bash
pip install -r requirements.txt
```

**Run Development Server:**
```bash
python manage.py runserver 8020
```

**Database Operations:**
```bash
python manage.py migrate
python manage.py createsuperuser --no-input
python manage.py seed polls --number=5
```

**Testing and Code Quality:**
```bash
python manage.py test
flake8 .
coverage run --source='.' manage.py test
```

## Architecture Overview

### Application Structure
- **vuln_django/**: Main Django project configuration
  - `settings.py`: Django settings with intentionally relaxed security
  - `urls.py`: Root URL configuration
- **polls/**: Main application with polling functionality
  - `models.py`: Question and Choice models
  - `views.py`: Contains vulnerable views with CSRF exemptions
  - `templates/`: HTML templates for polls interface
- **templates/**: Shared templates including admin customizations

### Key Components

**Database Support:**
- SQLite (default for local development)
- PostgreSQL (microservice deployment)
- MySQL (supported via mysqlclient)

**Vulnerable Endpoints:**
- `/polls/inject/<str:injector_str>/`: XSS vulnerability demonstration
- `/polls/sql_injector/`: SQL injection endpoint
- `/polls/search/`: Search functionality with potential XSS

**Security Features Disabled:**
- CSRF protection disabled on key views (`@csrf_exempt`)
- Debug mode configurable via environment variables
- Relaxed ALLOWED_HOSTS setting

### Docker Updates (2024)

The Docker configuration has been updated to work with modern systems:
- Base image upgraded from `python:3.7-buster` to `python:3.9-slim`
- Added system dependencies for building Python packages (build-essential, libmysqlclient-dev, libpq-dev)
- Updated Python dependencies to compatible versions while preserving vulnerabilities
- Fixed dependency conflicts (e.g., Markdown version compatibility with martor)

### Environment Configuration

The application uses environment variables for configuration:
- `SECRET_KEY`: Django secret key
- `DEBUG`: Enable/disable debug mode
- `DJANGO_ALLOWED_HOSTS`: Space-separated allowed hosts
- `SQL_*` variables: Database configuration (ENGINE, DATABASE, USER, PASSWORD, HOST, PORT)

### Testing Framework

- Uses Django's built-in testing framework
- Run tests with `python manage.py test`
- Coverage reporting available via coverage.py
- Seeds test data with `python manage.py seed polls --number=5`

### CI/CD Integration

Multiple CI/CD configurations provided:
- GitLab CI variants (BASE, LOCAL, REMOTE, HAWKSCAN)
- Travis CI (`stackhawk-travis.yml`)
- CircleCI (`stackhawk-circleci.yml`)
- StackHawk security scanning integration

## Development Notes

- Default admin credentials: admin/adminpassword
- Application runs on port 8020 by default
- Uses `django-seed` for generating test data
- Request logging enabled via `django-request-logging`
- Static files served from `/static/` URL path