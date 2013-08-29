#!/usr/bin/env coffee

# Requires
express = require "express"
bugsnag = require "bugsnag"

# Load bugsnag notification support
bugsnag.register("6796ac4207703a9c343bf7777587a4dd", 
  notifyReleaseStages: ["production", "development"],  
  notifyHost: "localhost", 
  notifyPort: 8000,
  useSSL: false)

# Configure the web server
app = express()
app.use bugsnag.requestHandler
app.use app.router

app.use (err, req, res, next) =>
  bugsnag.errorHandler(err, req, res, next) unless err.domainEmitter || err.domainBound

app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'

# Index
app.get "/", (req, res, next) ->
  res.render('index')

# SYNC ERRORS
app.get "/notify", (req, res, next) ->
  bugsnag.notify new Error("this is the message")
  res.render('index')

app.get "/uncaught", (req, res, next) ->
  throw new Error("this is the message")

app.get "/callback", (req, res, next) ->
  testFunc bugsnag.intercept () ->
    console.log "Will never log"

app.get "/emitter", (req, res, next) ->
  eventEmitter = new (require('events').EventEmitter)()
  eventEmitter.emit "error", new Error("Something went wrong")

# ASYNC ERRORS
app.get "/async/notify", (req, res, next) ->
  process.nextTick ->
    bugsnag.notify new Error("this is the message")
  res.render('index')

app.get "/async/uncaught", (req, res, next) ->
  process.nextTick ->
    throw new Error("this is the async message")

app.get "/async/callback", (req, res, next) ->
  process.nextTick ->
    testFunc bugsnag.intercept () ->
      console.log "Will never log"

app.get "/async/emitter", (req, res, next) ->
  eventEmitter = new (require('events').EventEmitter)()
  process.nextTick ->
    eventEmitter.emit "error", new Error("Something went wrong")

testFunc = (cb) ->
  cb(new Error("Something went wrong"))

# Start the web server
app.listen 8080
console.log "Server running"