require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"

mg.connect('mongodb://localhost/bratstvost-3')
{Notice} = require "./models/notice"
{Event} = require "./models/event"

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
  .use(app.router)
  .use(exs.static("public"))


app.locals =
  formatDate: (date) -> moment(date).fromNow()

POST_PER_PAGE = 10

app.get "/", (req, res) ->
  res.render("index")

app.get "/contacts", (req, res) ->
  res.render("index")

app.get "/about", (req, res) ->
  res.render("index")

app.get "/api/events", (req, res) ->
  Event.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/notice", (req, res) ->
  Notice.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

port = process.env.PORT || 5000
app.listen(port)
console.log "start server on port #{port}".green