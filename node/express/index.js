// Generated by CoffeeScript 1.3.3
(function() {
  var app, bugsnag, express, testFunc,
    _this = this;

  express = require("express");

  bugsnag = require("bugsnag");

  bugsnag.register("6796ac4207703a9c343bf7777587a4dd", {
    notifyReleaseStages: ["production", "development"],
    notifyHost: "localhost",
    notifyPort: 8000,
    useSSL: false
  });

  app = express();

  app.use(bugsnag.requestHandler);

  app.use(app.router);

  app.use(function(err, req, res, next) {
    if (!(err.domainEmitter || err.domainBound)) {
      return next(err);
    }
  });

  app.use(bugsnag.errorHandler);

  app.set('views', __dirname + '/views');

  app.set('view engine', 'ejs');

  app.get("/", function(req, res, next) {
    return res.render('index');
  });

  app.get("/notify", function(req, res, next) {
    bugsnag.notify(new Error("this is the message"));
    return res.render('index');
  });

  app.get("/uncaught", function(req, res, next) {
    throw new Error("this is the message");
  });

  app.get("/callback", function(req, res, next) {
    return testFunc(bugsnag.intercept(function() {
      return console.log("Will never log");
    }));
  });

  app.get("/emitter", function(req, res, next) {
    var eventEmitter;
    eventEmitter = new (require('events').EventEmitter)();
    return eventEmitter.emit("error", new Error("Something went wrong"));
  });

  app.get("/async/notify", function(req, res, next) {
    process.nextTick(function() {
      return bugsnag.notify(new Error("this is the message"));
    });
    return res.render('index');
  });

  app.get("/async/uncaught", function(req, res, next) {
    return process.nextTick(function() {
      throw new Error("this is the async message");
    });
  });

  app.get("/async/callback", function(req, res, next) {
    return process.nextTick(function() {
      return testFunc(bugsnag.intercept(function() {
        return console.log("Will never log");
      }));
    });
  });

  app.get("/async/emitter", function(req, res, next) {
    var eventEmitter;
    eventEmitter = new (require('events').EventEmitter)();
    return process.nextTick(function() {
      return eventEmitter.emit("error", new Error("Something went wrong"));
    });
  });

  testFunc = function(cb) {
    return cb(new Error("Something went wrong"));
  };

  app.listen(8080);

  console.log("Server running");

}).call(this);