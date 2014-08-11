mg = require "mongoose"
{Schema} = mg

NewsSchema = new Schema
  type: { type: String, default: "news" }
  date: Date
  body: String
  published: { type: Boolean, default: yes }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.News = mg.model('News', NewsSchema)