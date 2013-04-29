require "colors"
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
    if events.length > 0
      last_update = events[0].updated
      for ev in events
        last_update = ev.updated if ev.updated > last_update
      res.locals
        events:   events
        last_update: "обновлено "+moment(last_update).fromNow()
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



class EventsController

  ns: "/events"

  constructor: (@srv) ->
    @srv.ws.on('connection', @on_connection)

  on_connection: (@sock) =>
    @sock.on('disconnect', @on_disconnect)
    @sock.on('create', @on_create)
    @sock.on('read', @on_read)
    @sock.on('update', @on_update)
    @sock.on('delete', @on_delete)

  on_disconnect: =>
    @sock = undefined

  on_create: (data, callback) =>
    console.log "CREATE".magenta, data
    ev = new Event(data)
    ev.save(callback)

  on_read: (data, callback) =>
    console.log "READ".magenta, data
    Event.find {archived: no}, null, {sort: "date"}, (err, results) =>
      console.log err, results
      callback(err, results)

  on_update: (data, callback) =>
    console.log "UPDATE".magenta, data
    _id = data._id
    delete data._id
    Event.findByIdAndUpdate _id, data, {upsert: yes}, (err, results) =>
      console.log err, results
      callback(err, results)

  on_delete: (data, callback) =>
    console.log "DELETE".magenta, data
    Event.remove { _id: data._id }, (err, results) =>
      console.log err, results
      callback(err, results)


new EventsController(app)
server.listen(3000)