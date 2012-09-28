#!/usr/bin/env python

import bugsnag

class BugsnagNonFatalException(Exception): pass
class BugsnagFatalException(Exception): pass

bugsnag.configure(
    api_key="059ee1fa4923cdeb62fd7fb9b25a839a",
    endpoint="localhost:8000",
    release_stage="development",
    notify_release_stages=["production", "development"],
    junk="junk",
)

bugsnag.configure_request(
    extra_data={
        "james": "is awesome for sure",
    },
    user_id="james"
)

bugsnag.notify(
    BugsnagNonFatalException("Oh dear non fatal exception"),
    extra_data={"james": "overwrote the extra_data"},
)

raise BugsnagFatalException("Oh dear fatal exception")