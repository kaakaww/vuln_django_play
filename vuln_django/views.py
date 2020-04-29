from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse
from django.views import generic
from django.utils import timezone
from django.db import connection
from urllib.parse import unquote
from django.views.decorators.csrf import csrf_exempt


@csrf_exempt
def redirect_to_polls(request, ):
    return HttpResponseRedirect('/polls')
