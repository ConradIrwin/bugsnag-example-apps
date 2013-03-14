#!/usr/bin/env python

import bugsnag
from bugsnag.wsgi.middleware import BugsnagMiddleware

from wsgiref.simple_server import make_server
from cgi import parse_qs, escape

# Create our wsgi app
def application(environ, start_response):
    if environ.get('PATH_INFO', '') == "/":
        d = parse_qs(environ['QUERY_STRING'])

        raise Exception("Something broke")

        start_response('200 OK', [('Content-Type', 'text/html')])
        return ["Some output here"]
    else:
        start_response('404 NOT FOUND', [('Content-Type', 'text/plain')])
        return ['Not Found']

# Configure bugsnag
bugsnag.configure(api_key="dcc345d219ef5107c6ce8aca68a40af2")

# Add bugsnag wsgi middleware to app
application = BugsnagMiddleware(application)

# Start a server
httpd = make_server('localhost', 8051, application)
httpd.serve_forever()