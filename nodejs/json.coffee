express = require 'express'

responseJson = (res) ->
  res.writeHead 200, {
  'Content-Type': 'text/plain'
  "Access-Control-Allow-Origin": "*"
  }

  entry =
    title: 'AngularJSTutorial'
    name: 'hisasann'

  res.write JSON.stringify(entry)
  res.end()

app = express.createServer()
app.set 'view options', { layout: false }
app.get '/', (req, res) ->
  responseJson res

app.listen 8124

console.log 'http://127.0.0.1:8124/'