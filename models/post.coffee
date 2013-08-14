mg = require "mongoose"
{Schema} = mg

PostSchema = new Schema
  title: String
  content: String
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.Post = mg.model('Post', PostSchema)

###
title
title_plain
type
content — Add a short text summary to the end of the post URL
excerpt — Short text
###