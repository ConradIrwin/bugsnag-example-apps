var restify = require('restify');

var bugsnag = require("bugsnag");
bugsnag.register("13686661989c6c85aff27eddac945ec6", {
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

server.get('/', function get(req, res, next) {

  throw new Error("yddo");

  res.send("hello this is a normal response");
  return next();
});

server.listen(9123, function() {
  console.log("Listening!");
})

server.on("uncaughtException", function (req, res, route, e) {
  if (!res._headerSent) res.send(new restify.InternalError(e, e.message || 'unexpected error'));
});
server.on("uncaughtException", bugsnag.restifyHandler);