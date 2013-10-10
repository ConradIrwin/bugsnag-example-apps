var restify = require('restify');

var bugsnag = require("bugsnag");
bugsnag.register("6796ac4207703a9c343bf7777587a4dd", {
  notifyReleaseStages: ["production", "development"],
  notifyHost: "localhost",
  notifyPort: 8000,
  useSSL: false,
  logLevel: "info"
});

var server = restify.createServer();

server.use(restify.acceptParser(server.acceptable));
server.use(restify.queryParser());
server.use(restify.bodyParser());

// server.use(bugsnag.requestHandler);
// server.use(bugsnag.errorHandler);

server.get('/', function get(req, res, next) {

  throw new Error("yddo");

  res.send("hello this is a normal response");
  return next();
});

server.listen(9123, function() {
  console.log("Listening!");
})

server.on("uncaughtException", function(req, res, route, err){
  bugsnag.notify(err, {req: req});
  if (res._headerSent) {
    return (false);
  }

  res.send(new restify.InternalError(err, err.message || 'unexpected error'));
  return (true);
});