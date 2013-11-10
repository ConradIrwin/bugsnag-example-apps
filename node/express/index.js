var express = require('express')
    , http = require('http')
    , path = require('path')

var bugsnag = require("bugsnag");
bugsnag.register("066f5ad3590596f9aa8d601ea89af845")

var app = exports.app = express();

// all environments
app.enable('trust proxy');
app.set('port', process.env.PORT || 4000); // Port
app.set('views', __dirname + '/views');
app.set('view engine', 'jade'); // Templating engine
app.set('view cache', true); // Cache views
app.set('app version', '0.0.2'); // App version
app.locals.pretty = process.env.NODE_ENV != 'production' // Pretty HTML outside production mode

app.use(bugsnag.requestHandler);
app.use(express.logger('dev')); // Pretty log
app.use(express.limit('25mb')); // File upload limit
app.use("/", express.static(path.join(__dirname, 'public'))); // serve static files
app.use(express.bodyParser()); // Parse the request body
app.use(express.cookieParser()); // Parse cookies from header
app.use(express.methodOverride());

// development only
if ('development' == app.get('env')) {
    app.use(express.errorHandler()); // Let xpress handle errors
    app.set('view cache', false); // Tell Jade not to cache views
}

var server = http.createServer(app)
server.listen(app.get('port'), function(){
    console.log('Express server listening on port ' + app.get('port'));
});

app.use(app.router);
app.post("/", function(req, res){
  var body = 'Hello World';
  res.setHeader('Content-Type', 'text/plain');
  res.setHeader('Content-Length', body.length);
  res.end(body);
  throw new Error("WHOOPS");
})

app.use(bugsnag.errorHandler);

// routes
//routes.router(app);