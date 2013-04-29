require "colors"

mg = require "mongoose"
{Schema} = mg

mg.connect('mongodb://localhost/bratstvost')

ObjectId = Schema.Types.ObjectId

EventSchema = new Schema
  _id: String
  title: String
  desc: String
  date: Date
  verified: { type: Boolean, default: no }
  archived: { type: Boolean, default: no }
  updated: { type: Date, default: Date.now }
  info: [
    icon: String
    term: String
    desc: String
  ]
,  _id: false

Event = mg.model('Event', EventSchema)

try
  ev = new Event({"_id":"10A45CC6-8B97-4E98-B90F-AC43572A3CF0","title":"Куль","desc":"Выезд в психоневрологический интернат в д. Куль.","verified":false,"archived":false,"updated":"2013-04-23T13:04:00.090Z","info":[{"icon":"user","term":"Организатор","desc":"брат Сергий, тел. <a href=\"phone:00375293737250\">8 (029) 373-72-50</a>"},{"icon":"time","term":"Время выезда","desc":"12:00"}],"date":"2013-04-22T21:00:00.000Z"})
  ev.save (err, res) ->
    console.log "save".magenta, err, res, "\n\n"
    Event.find (err, res) ->
      console.log "find".magenta, err, res
catch e
  console.log e