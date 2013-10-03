require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"

mg.connect('mongodb://localhost/bratstvost-3')
{Post} = require "./models/post"
{Event} = require "./models/events"

_ = require "lodash"
require("uasync")(_)

app = exs()

app
  .disable("x-powered-by")
  .set("view engine", "ect")
  .engine('ect', ect(
      root : __dirname + '/views'
      ext : '.ect'
      cache: no
    ).render)
  
app 
  .use(exs.bodyParser())
  .use(exs.logger("short"))
  .use(exs.static("public"))
  .use(app.router)


app.locals =
  formatDate: (date) -> moment(date).fromNow()

POST_PER_PAGE = 10

app.get "/api/events", (req, res) ->
  console.log "GET /api/events"
  Event.find {}, (err, results) ->
    console.log "find completion", err, results
    return res.json(status: "ERR", message: err) if err
    res.json(results)


app.post "/api/events", (req, res) ->
  Event.create(req.body).exec (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.put "/api/events", (req, res) ->
  id = req.body.id
  Event.findByIdAndUpdate(id, req.body).exec (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.del "/api/events", (req, res) ->
  Event.findByIdAndRemove(req.body.id).exec (err, result) ->
    return res.json(status: "ERR", message: err) if err
    res.json(status: "OK")

app.all "*", (req, res) ->
  console.log "GET all *"
  res.render("index")

port = process.env.PORT || 5001
app.listen(port)
console.log "start server on port #{port}".green