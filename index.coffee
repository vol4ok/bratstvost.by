require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"

mg.connect('mongodb://127.0.0.1/bratstvost-3')
{Notice} = require "./models/notice"
{Event} = require "./models/event"
{News} = require "./models/news"
{Article} = require "./models/article"
{Video} = require "./models/video"

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

COOKIE_SECRET = 'tarasiki-2013'
  
app 
  .use(exs.urlencoded())
  .use(exs.json())
  .use(exs.cookieParser(COOKIE_SECRET))
  .use(exs.session(key: 'sid'))
  .use(exs.logger("short"))
  .use(app.router)
  .use(exs.static("public"))
  .use (req, res) ->
    if req.session
      res.render("index")
    else
      req.session.regenerate ->
        res.render("index")

app.locals =
  formatDate: (date) -> moment(date).fromNow()

POST_PER_PAGE = 10

app.get "/api/events", (req, res) ->
  Event.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/notice", (req, res) ->
  Notice.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/news", (req, res) ->
  News.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/videos", (req, res) ->
  Video.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/article", (req, res) ->
  Article.find {published: yes}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

port = process.env.PORT || 5000
app.listen(port)
console.log "start server on port #{port}".green