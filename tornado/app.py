#!/usr/bin/env python

import bugsnag
from bugsnag.tornado import BugsnagRequestHandler

import tornado.ioloop
import tornado.web

bugsnag.configure(api_key="dcc345d219ef5107c6ce8aca68a40af2")

class MainHandler(BugsnagRequestHandler):
    def get(self):
        raise Exception("fucked")
        self.write("Hello, world")

application = tornado.web.Application([
    (r"/", MainHandler),
])

if __name__ == "__main__":
    application.listen(8888)
    tornado.ioloop.IOLoop.instance().start()