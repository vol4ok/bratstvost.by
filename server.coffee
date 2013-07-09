moment   = require "moment"
mongoose = require "mongoose"
moment   = require "moment"
express  = require "express"

moment.lang("ru")

{Event} = require "./event"
{News} = require "./news"

$ = require "lodash"
require("uasync")($)

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
  $.parallel {
    events: (cb) -> Event.find {published: yes}, null, {sort: "date"}, cb
    news: (cb) -> News.find {published: yes}, null, {sort: "-date"}, cb
  }, (err, results) ->
    last_update = results.events[0].updated
    for ev in results.events
      last_update = ev.updated if last_update < ev.updated
    res.locals
      last_update: last_update
      events: results.events
      news: results.news
      fromNow: (arg) -> moment(this).fromNow()
      formatDate: (fmt) -> moment(this).format(fmt)
      clickable: (arg) -> 
        return if @post_type in ["video", "picture", "link"] then "clickable" else ""
      formatPhone: (->
        phoneRexp = /^(\+|00)(\d\d\d)(\d\d)(\d\d\d)(\d\d)(\d\d)$/
        return (fmt) -> 
          m = phoneRexp.exec(@phone)
          return "8 (0#{m[3]}) #{m[4]}-#{m[5]}-#{m[6]}"
      )()
      classByType: (->
        t2c = 
          "video": "UIVideoNewsView"
          "picture": "UIPictureNewsView"
          "text": "UITextNewsView"
          "link": "UILinkNewsView"
          
        return (arg) -> 
          t2c[@post_type] || ""
      )()
      base64This: (arg) -> return new Buffer(JSON.stringify(this)).toString('base64')
    res.render("index")

app.get "/ev", (req, res) ->
  res.render("event")

app.get "/sample", (req, res) ->
  res.render("sample")

app.get "/archive", (req, res) ->
  res.send("archive")

app.get "/contacts", (req, res) ->
  res.send("contacts")