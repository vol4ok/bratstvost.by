mg = require "mongoose"
{Schema} = mg

EventSchema = new Schema
  type: { type: String, default: "event" }
  date: Date
  title: String
  body: String
  event_place: String
  event_time: String
  meeting_place: String
  meeting_time: String
  organizer: String
  phone: String
  cost: String
  custom_field: [
    icon: String
    term: String
    desc: String
  ]
  published: { type: Boolean, default: yes }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.Event = mg.model('Event', EventSchema)