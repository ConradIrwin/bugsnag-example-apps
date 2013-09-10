from django.http import HttpResponse
import logging
import sys

import bugsnag

def index(request):
  logging.getLogger("bugsnag").error("oh dear", exc_info = True)

  return HttpResponse("Hello, world. You're at the poll index.")

def another_fail(request):
  raise Exception("another oh dear")
    
  return HttpResponse("Hello, world. You're at the poll index.")