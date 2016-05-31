require "colors"
exs = require "express"
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
cookieSession = require('cookie-session')
compression = require('compression');
morgan = require('morgan')
mg  = require "mongoose"
moment = require "moment"
http = require "http"

mg.connect('mongodb://127.0.0.1/bratstvost-3')
{Notice} = require "./models/notice"
{Event} = require "./models/event"
{News} = require "./models/news"
{Video} = require "./models/video"
{Member} = require "./models/member"

_ = require "lodash"
require("uasync")(_)

app = exs()

app.disable("x-powered-by")

COOKIE_SECRET = 'tarasiki-2013'
  
app
  .use(compression())
  .use(bodyParser.urlencoded({extended: true}))
  .use(bodyParser.json())
  .use(cookieParser(COOKIE_SECRET))
  .use(cookieSession({ secret: 'uwotm8', cookie: { maxAge: 60 * 60 * 1000 } }))
  .use(morgan('short'))
  .use(exs.static("public"))

app.locals =
  formatDate: (date) -> moment(date).fromNow()

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

#  res.send('what???', 404)
app.get '*', (req, res) ->
  res.sendFile(__dirname+'/public/index.html');

port = process.env.PORT || 5000
app.listen(port)
console.log "start server on port #{port}".green