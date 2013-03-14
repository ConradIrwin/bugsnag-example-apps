#!/usr/bin/env python

import os

import bugsnag
from bugsnag.handlers import BugsnagHandler
from bugsnag.flask import handle_exceptions
from flask import Flask

# Configure bugsnag
bugsnag.configure(
    api_key="dcc345d219ef5107c6ce8aca68a40af2",
    project_root=os.path.dirname(os.path.realpath(__file__)),
)

# Create flask app
app = Flask(__name__)
handle_exceptions(app)

# app.logger.addHandler(BugsnagHandler());
# raise Exception("Oh dear fatal exception")

@app.route("/")
def hello():
    raise Exception("Oh dear fatal exception")
    return "Hello World!"

if __name__ == "__main__":
    app.run()