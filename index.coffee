require "colors"
exs = require "express"
ect = require "ect"
mg  = require "mongoose"
moment = require "moment"
http = require "http"

mg.connect('mongodb://127.0.0.1/bratstvost-3')
{Notice} = require "./models/notice"
{Event} = require "./models/event"
{News} = require "./models/news"
{Article} = require "./models/article"
{Video} = require "./models/video"
{Member} = require "./models/member"

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
  Notice.find {published: yes, show_ends: { $gt: new Date()}}, (err, results) ->
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

app.get "/api/members", (req, res) ->
  Member.find {active: yes}, null,  {sort:{orderNumber:1}}, (err, results) ->
    return res.json(status: "ERR", message: err) if err
    res.json(results)

app.get "/api/main", (req, res) ->
  today = moment(new Date()).startOf('day').toDate()
  Notice.find {published: yes, show_ends: { $gt: today}}, null, {sort:{priority:-1}}, (err, notices) ->
    return res.json(status: "ERR", message: err) if err
    News.find {published: yes}, null, {sort:{date:-1}, limit: 3} , (err, news) ->
      return res.json(status: "ERR", message: err) if err
      Event.find {published: yes, date: { $gt: today}}, (err, events) ->
        return res.json(status: "ERR", message: err) if err
        responseWithTodayCalendar(res, {"news": news, "notices": notices, "events": events})

dailyCalendarHtml = {html: "", date: null}
calendarOptions = { host: 'script2.pravoslavie.ru', path: '/cache/ssi=1&hrams=0&bold=1&para=1&dayicon=1&encoding=u&advanced=1.ls' }

responseWithTodayCalendar = (res, data) ->
  if moment().isSame(dailyCalendarHtml.date, 'day')
    data.calendarHtml = dailyCalendarHtml.html
    res.json(data)
  else
    calendarCallback = (response) ->
      calendarHtml = ""
      response.on 'data', (chunk) ->
        calendarHtml += chunk
      response.on 'end', () ->
        dailyCalendarHtml.html = data.calendarHtml = calendarHtml
        dailyCalendarHtml.date = new Date()
        return res.json(data)

    http.request(calendarOptions, calendarCallback).end();


port = process.env.PORT || 5000
app.listen(port)
console.log "start server on port #{port}".green