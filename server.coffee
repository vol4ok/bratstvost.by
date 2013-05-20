moment   = require "moment"
mongoose = require "mongoose"
moment   = require "moment"
express = require "express"

# ua = require "express-useragent"

{Event} = require "./event"

app = express()
  .use(express.static("public"))
  .use(express.logger('short'))
  .set("view engine", "mu")
  .set("views", "views")
  .engine("mu", require("hogan-express"))
  .disable("x-powered-by")
  .configure "production", ->
    @enable("view cache")

mongoose.connect('mongodb://localhost/bratstvost')
app.listen(4000)

app.set("meta-keyword", "")
app.set("meta-description", "")

app.get "/", (req, res) ->
  Event.find {published: yes}, null, {sort: "date"}, (err, result) ->
    res.locals
      events: result
      formatDate: (fmt) ->
        moment(@date).format(fmt)
    res.render("index")

app.get "/ev", (req, res) ->
  res.render("event")

app.get "/archive", (req, res) ->
  res.send("archive")

app.get "/contacts", (req, res) ->
  res.send("contacts")