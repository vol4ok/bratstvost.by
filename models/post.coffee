mg = require "mongoose"
{Schema} = mg

VideoDesc = new Schema


PostSchema = new Schema
  publish_date: { type: Date, default: Date.now }
  title: { type: String, trim: true }
  excerpt: String
  content: String
  type: { type: String, lowercase: true }
  video: 
    provider: { type: String }
    id: String
    url: String
    width: { type: Number, default: 480 }
    height: { type: Number, default: 360 }
    html: String
    thumbnail:
      url: String
      width: Number
      height: Number
    title: String
    description: String
    author: String
  source_url: String
  state: { type: String, lowercase: true, trim: true, deafult: "published" }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.Post = mg.model('Post', PostSchema)

###
title
title_plain
type
content — Add a short text summary to the end of the post URL
excerpt — Short text


title: String
title_plain: String
date: { type: Date, default: Date.now }
url: String
slug: String
state: String
type: String
event_id: String
location: 
  coord: 
    lat: 
    lag: 
  description:
thumb:
  url: String
  width: Number
  height: Number
video:
  url:
  embed_code:
  description: 
photo:
  photos: [
      caption:
      url:
      width:
      height: 
      alt_sizes: [
          url:
          width:
          height: 
      ]
  ]
  description:
text:
  format: String
  excerpt: String
  content: String
tags: [String]
category: [String]
source: String
created: { type: Date, default: Date.now }
updated: { type: Date, default: Date.now }
###