mg = require "mongoose"
{Schema} = mg

ArticleSchema = new Schema
  date: { type: Date, default: Date.now }
  title: { type: String, trim: true }
  slug: { type: String, trim: true }
  excerpt: String
  content: String
  published: { type: Boolean, default: yes }
  created: { type: Date, default: Date.now }
  updated: { type: Date, default: Date.now }

exports.Article = mg.model('Article', ArticleSchema)