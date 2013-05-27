moment   = require "moment"
mongoose = require "mongoose"
moment   = require "moment"
express  = require "express"

moment.lang("ru")

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
      formatDate: (fmt) -> moment(this).format(fmt)
      formatPhone: (->
        phoneRexp = /^(\+|00)(\d\d\d)(\d\d)(\d\d\d)(\d\d)(\d\d)$/
        return (fmt) -> 
          m = phoneRexp.exec(@phone)
          return "8 (0#{m[3]}) #{m[4]}-#{m[5]}-#{m[6]}"
      )()
    res.render("index")

app.get "/ev", (req, res) ->
  res.render("event")

app.get "/sample", (req, res) ->
  res.render("sample")

app.get "/archive", (req, res) ->
  res.send("archive")

app.get "/contacts", (req, res) ->
  res.send("contacts")