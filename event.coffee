mongoose = require "mongoose"
{Schema} = mongoose

EventSchema = new Schema
  _id: String
  date: Date
  title: String
  desc: String
  hasTime: { type: Boolean, default: no }
  published: { type: Boolean, default: no }
  updated: { type: Date, default: Date.now }
  , _id: false

exports.Event = mongoose.model('Event', EventSchema)