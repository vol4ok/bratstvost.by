mg = require "mongoose"
{Schema} = mg

VideoSchema = new Schema
  video_id: { type: String, trim: true }
  publish_date: { type: Date, default: Date.now }
  title: { type: String, trim: true }
  content: { type: String, trim: true }
  url: { type: String, trim: true }
  thumb_url: { type: String, trim: true }
  source_url: { type: String, trim: true }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }
  published: { type: Boolean, default: yes }

exports.Video = mg.model('Video', VideoSchema)