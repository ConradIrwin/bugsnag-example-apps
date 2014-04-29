#!/usr/bin/env python

import bugsnag
from bugsnag.tornado import BugsnagRequestHandler

import tornado.ioloop
import tornado.web

bugsnag.configure(api_key="066f5ad3590596f9aa8d601ea89af845")

class MainHandler(BugsnagRequestHandler):
    def get(self):
        raise Exception("oops")
        self.write("Hello, world")

application = tornado.web.Application([
    (r"/", MainHandler),
])

if __name__ == "__main__":
    print("Listening on :8888")
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()
