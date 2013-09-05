mg = require "mongoose"
{Schema} = mg

EventSchema = new Schema
  _id: String
  type: { type: String, default: "event" }
  date: Date
  title: String
  head: String
  body: String
  event_place: String
  event_time: Date
  meeting_place: String
  meeting_time: Date
  organizer: String
  priest: String
  phone: String
  cost: String
  custom_field: [
    icon: String
    term: String
    desc: String
  ]
  published: { type: Boolean, default: no }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }
  , _id: false

exports.Event = mg.model('Event', EventSchema)