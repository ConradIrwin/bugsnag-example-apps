from django.http import HttpResponse

import bugsnag

def index(request):
    bugsnag.configure_request(extra_data = {"james": "is testing"})
    
    
    raise Exception("oh dear")
    return HttpResponse("Hello, world. You're at the poll index.")

def another_fail(request):
    raise Exception("another oh dear")
    
    return HttpResponse("Hello, world. You're at the poll index.")