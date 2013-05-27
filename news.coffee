mongoose = require "mongoose"
{Schema} = mongoose

NewsSchema = new Schema
  _id: String
  type: { type: String, default: "news" }
  post_type: "video"
  date: Date
  title: String
  head: String
  body: String
  thumb_url: String 
  thumb_alt: String
  context: {
    video_host: String
    video_id: String
  }
  published: { type: Boolean, default: no }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }
  , _id: false

exports.Event = mongoose.model('Event', EventSchema)