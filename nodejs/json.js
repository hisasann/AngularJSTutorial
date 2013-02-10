(function() {
  var app, express, responseJson;

  express = require('express');

  responseJson = function(res) {
    var entry;
    res.writeHead(200, {
      'Content-Type': 'text/plain',
      "Access-Control-Allow-Origin": "*"
    });
    entry = {
      title: 'AngularJSTutorial',
      name: 'hisasann'
    };
    res.write(JSON.stringify(entry));
    return res.end();
  };

  app = express.createServer();

  app.set('view options', {
    layout: false
  });

  app.get('/', function(req, res) {
    return responseJson(res);
  });

  app.listen(8124);

  console.log('http://127.0.0.1:8124/');

}).call(this);
