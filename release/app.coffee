require "colors"
$ = require "core.js"
express = require "express"
app = express()
server = require('http').Server(app)
app.ws = require('socket.io').listen(server)
moment = require 'moment'
moment.lang("ru")

mg = require "mongoose"
{Schema} = mg

mg.connect('mongodb://localhost/bratstvost')

EventSchema = new Schema
  _id: String
  title: String
  desc: String
  date: Date
  hasTime: { type: Boolean, default: no }
  published: { type: Boolean, default: no }
  verified: { type: Boolean, default: no }
  archived: { type: Boolean, default: no }
  updated: { type: Date, default: Date.now }
  info: [
    icon: String
    term: String
    desc: String
  ]
  , _id: false
Event = mg.model('Event', EventSchema)

NewsSchema = new Schema
  _id: String
  title: String
  short_body: String
  full_body: String
  date: Date
  published: { type: Boolean, default: no }
  updated: { type: Date, default: Date.now }
  , _id: false

News = mg.model('News', NewsSchema)

configure = ->
  @use(express.favicon())
  @use(express.static(__dirname))
  @use(express.errorHandler())

  @ws?.configure =>
    @ws.set('log level', 1)
    @ws.set('transports', ['websocket', 'xhr-polling'])

  @set("views", __dirname)
  @set("view engine", "mu")
  @engine('mu', require('hogan-express'))


configure.call(app)
module.exports = app

app.get '/', (req, res) ->
  Event.find {published: yes, archived: no}, null, {sort: "date"}, (err, events) =>
    News.find {published: yes}, null, {sort: "date"}, (err, news) =>
      if events.length > 0
        last_update = events[0].updated
        result_events = []
        for ev in events
          last_update = ev.updated if ev.updated > last_update
          if moment(ev.date).startOf('day') < moment().startOf('day')
            ev.archived = yes
            ev.save()
          else
            result_events.push(ev)
        nw_last_update = news[0].updated
        for nw in news
          nw_last_update = nw.updated if nw.updated > nw_last_update
        res.locals
          events:      result_events
          news:        news
          last_update: moment(last_update).fromNow()
          nw_last_update: moment(nw_last_update).fromNow()
          formatDate: (date) -> return moment(@date).format("D MMMM, YYYY")
          getDay:   (date) -> return moment(@date).format("D")
          getMonth: (date) -> return moment(@date).format("MMM")
          getTime:  (date) -> return moment(@date).format("HH:mm")
          getColor: (date) -> 
            d = moment(@date).startOf('day').diff(moment().startOf('day'), 'days')
            if d > 1
              return "green"
            else if d == 1
              return "yellow"
            return "red"
      res.render("index.mu")

app.get '/news/:id', (req, res) ->
  News.findById req.params.id, (err, news) =>
    console.log news
    res.locals
      news:       news
      formatDate: (date) -> return moment(@date).format("D MMMM, YYYY")
    res.render("news.mu")


class EventsController

  ns: "/events"

  constructor: (@srv) ->
    @srv.ws.of(@ns).on('connection', @on_connection)

  on_connection: (@sock) =>
    @sock.on('disconnect', @on_disconnect)
    @sock.on('create', @on_create)
    @sock.on('read', @on_read)
    @sock.on('update', @on_update)
    @sock.on('delete', @on_delete)

  on_disconnect: =>
    @sock = undefined

  on_create: (data, callback) =>
    console.log "CREATE EVENT".magenta, data
    ev = new Event(data)
    ev.save(callback)

  on_read: (data, callback) =>
    console.log "READ EVENTS".magenta, data
    Event.find {}, null, {sort: "date"}, (err, results) =>
      console.log err, results
      callback(err, results)


  on_update: (data, callback) =>
    console.log "UPDATE EVENT".magenta, data
    _id = data._id
    delete data._id
    if moment(data.date).startOf('day') < moment().startOf('day')
      data.archived = yes
    else
      data.archived = no
    Event.findByIdAndUpdate _id, data, {upsert: yes}, (err, results) =>
      console.log err, results
      callback(err, results)
      

  on_delete: (data, callback) =>
    console.log "DELETE EVENT".magenta, data
    Event.remove { _id: data._id }, (err, results) =>
      console.log err, results
      callback(err, results)



class NewsController

  ns: "/news"

  constructor: (@srv) ->
    @srv.ws.of(@ns).on('connection', @on_connection)

  on_connection: (@sock) =>
    @sock.on('disconnect', @on_disconnect)
    @sock.on('create', @on_create)
    @sock.on('read', @on_read)
    @sock.on('update', @on_update)
    @sock.on('delete', @on_delete)

  on_disconnect: =>
    @sock = undefined

  on_create: (data, callback) =>
    console.log "CREATE NEWS".magenta, data
    news = new News(data)
    news.save(callback)

  on_read: (data, callback) =>
    console.log "READ NEWS".magenta, data
    News.find {}, null, {sort: "date"}, (err, results) =>
      console.log err, results
      callback(err, results)

  on_update: (data, callback) =>
    console.log "UPDATE NEWS".magenta, data
    _id = data._id
    delete data._id
    News.findByIdAndUpdate _id, data, {upsert: yes}, (err, results) =>
      console.log err, results
      callback(err, results)

  on_delete: (data, callback) =>
    console.log "DELETE NEWS".magenta, data._id
    News.remove { _id: data._id }, (err, results) =>
      console.log err, results
      callback(err, results)




new EventsController(app)
new NewsController(app)


server.listen(3000)