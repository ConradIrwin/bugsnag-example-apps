#!/usr/bin/env coffee

# Requires
express = require "express"
bugsnag = require "bugsnag"

# Load bugsnag notification support
bugsnag.register("8999dadca0141ee777ef21dfff32e4d7", 
  notifyReleaseStages: ["production", "development"],  
  notifyHost: "localhost", 
  notifyPort: 8000, 
  useSSL: false)

# Configure the web server
app = express()
app.use bugsnag.requestHandler
app.use app.router

app.use bugsnag.errorHandler
app.use (err, req, res, next) =>
  res.send "Error occured:<br />#{err.stack}", 500
  next err
app.set 'views', __dirname + '/views'
app.set 'view engine', 'ejs'

# Index
app.get "/", (req, res, next) ->
  res.render('index')

# SYNC ERRORS
app.get "/uncaught", (req, res, next) ->
  throw new Error("this is the message")

app.get "/callback", (req, res, next) ->
  testFunc bugsnag.intercept () ->
    console.log "Will never log"

app.get "/emitter", (req, res, next) ->
  eventEmitter = new (require('events').EventEmitter)()
  eventEmitter.emit "error", new Error("Something went wrong")

# ASYNC ERRORS
app.get "/async/uncaught", (req, res, next) ->
  process.nextTick () ->
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