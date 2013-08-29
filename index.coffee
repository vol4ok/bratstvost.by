require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"

mg.connect('mongodb://localhost/bratstvost-3')
{Post} = require "./models/post"
{Event} = require "./models/post"

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

app.get "/events", (req, res) ->
  res.render("events")

app.listen(3001)
console.log "start server on port 3001".green