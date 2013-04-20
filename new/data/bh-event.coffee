$ = require "core.js"
$.ext require "fs"

marked = require "marked"
moment = require "moment"
require "./translit"

# mg = require "mongoose"

# mg.connect('mongodb://localhost/bratstvost')

# EventSchema = new Schema
#   title: String
#   desc: String
#   date: Date
#   verified: { type: Boolean, default: no }
#   archived: { type: Boolean, default: no }
#   updated: { type: Date, default: Date.now }
#   info: [
#     icon: String
#     term: String
#     desc: String
#   ]

striped_md = (->
  rexp = /^<p>(.*)<\/p>\s*$/
  (str) -> 
    md = marked(str)
    if rexp.test(md) then RegExp.$1 else md
)()

class BHEvent

  # @findById = (id) ->
  # @findByUpdateDate = (from, to) ->
  # @findByDate = (from, to) ->

  constructor: (data) ->
    @data = new EventSchema
      _id:       $.guid()
      title:    data.title
      desc:     striped_md(data.desc)
      verified: data.verified or no
      archived: data.archived or no
      updated:  new Date
      info:     []

    date = data.date || "invalid date"
    @data.date = if moment(date).isValid() 
      moment(date).toDate()
    else if moment(date, "DD.MM.YY").isValid()
      moment(date, "DD.MM.YY").toDate()
    else if moment(date, "DD.MM.YYYY").isValid()
      moment(date, "DD.MM.YYYY").toDate()

    for src in data.info
      info = 
        icon: src.icon 
        term: src.term
        desc: striped_md(src.desc)
      @data.info.push(info)


  addInfo: (icon, term, desc) ->
    src = arguments[0]
    if $.isString(src)
      src = 
        icon: icon
        term: term
        desc: desc
    info = 
      icon: src.icon 
      term: src.term
      desc: striped_md(src.desc)
    @data.info.push(info)

  get: (field) -> @data[field]
  set: (field) -> @data["field"] = value


  json: (pretty) -> 
    return if pretty 
      JSON.stringify(@data, null, 2)
    else
      JSON.stringify(@data)


  uniqName: ->
    name = @data.title.translit()
    name += if @data.date
      "-" + moment(@data.date).format("DD.MM.YY")
    else
      "_" + moment(@data.updated).format("DD.MM.YY")
    return name

  save: ->


  export: (filename) ->
    $.writeFileSync(filename || "#{@uniqName()}.json", @json(yes), "utf-8")

exports.BHEvent = BHEvent