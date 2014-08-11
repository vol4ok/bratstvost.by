mg = require "mongoose"
{Schema} = mg

NoticeSchema = new Schema
  type: { type: String, default: "notice" }
  body: String
  show_begins: { type: Date, default: Date.now }
  show_ends: { type: Date, default: "9999-12-31T23:59:59.999Z" }
  priority: { type: Number, default: 0 }
  style: String
  published: { type: Boolean, default: yes }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.Notice = mg.model('Notice', NoticeSchema)