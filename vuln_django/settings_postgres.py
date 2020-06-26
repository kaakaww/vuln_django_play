from .settings import *

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'django_db',
        'HOST': 'postgres',
        'USER': 'django_user',
        'PASSWORD': 'django_password',
    }
}
