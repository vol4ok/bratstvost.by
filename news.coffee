mongoose = require "mongoose"
{Schema} = mongoose

NewsSchema = new Schema
  _id: String
  type: { type: String, default: "news" }
  post_type: String
  date: Date
  title: String
  head: String
  body: String
  thumb: String 
  video: {
    host: String
    id: String
  }
  images: {
    s: [ String ]
    m: [ String ]
    l: [ String ]
  }
  published: { type: Boolean, default: no }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }
  , _id: false

exports.News = mongoose.model('News', NewsSchema)