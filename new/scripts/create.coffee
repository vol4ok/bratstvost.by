Backbone.__classes = {}
Backbone.__objects = {}
Backbone.registerClass = Backbone.View.registerClass = (name, klass=this) -> Backbone.__classes[name] = klass
Backbone.getClassByName = (name) -> Backbone.__classes[name]

Backbone.registerObject = Backbone.View::registerObject = (name, obj=this) -> Backbone.__objects[name] = obj
Backbone.getObjectByName = Backbone.View::getObjectByName = (name) -> Backbone.__objects[name]

bindEvent = (src, trg) ->
  $$ = Backbone.getObjectByName 
  [srcObj, event]  = if (t = src.split(' ')).length is 1 then [this, t[0]] else [$$(t[0]), t[1]]
  [trgObj, method] = if (t = trg.split(' ')).length is 1 then [this, t[0]] else [$$(t[0]), t[1]]
  srcObj.on(event, trgObj[method])

bindEvents = (events) ->
  return unless events
  for src, trg of events
    bindEvent(src, trg)

class UIView extends Backbone.View
  constructor: ->
    super
    @registerObject(@id or @$el.attr("id") or @cid)


class Application extends Backbone.Router

  constructor: ->
    @load = false
    @laoded = false
    $(@__on_load)

  initAutoloadObjects: =>
    $(".autoload").each (index, el) ->
      $el = $(el)
      new (Backbone.getClassByName($el.data('class')))(el: $el)
      $el.removeClass("autoload")
      $el.removeData("class")

  on: (eventname, callback) ->
    if @load and eventname == "load"
      callback()
    if @loaded and eventname == "loaded"
      callback()
    super

  __on_load: =>
    @load = true
    @trigger("load", this)
    _.defer @__on_laoded

  __on_laoded: =>
    @loaded = true
    @trigger("loaded", this)


Model = Backbone.Model
Collection = Backbone.Collection


Backbone.sync = (method, model, options) ->
  console.log "sync", method.toUpperCase, model, options

  sock = io.connect('http://localhost:3000')
  sock.emit method, model, (err, data) ->
    console.log "sync-complete", err, data
    unless err
      options.success(data)
    else
      options.error(data)
    

String::capitalize = ->
    return this.substr(0, 1).toUpperCase() + this.substr(1)

String::translit = (->
  L = 
    "А": "A",   "а": "a",   "Б": "B",   "б": "b",   "В": "V",   "в": "v"
    "Г": "G",   "г": "g",   "Д": "D",   "д": "d",   "Е": "E",   "е": "e"
    "Ё": "Yo",  "ё": "yo",  "Ж": "Zh",  "ж": "zh",  "З": "Z",   "з": "z"
    "И": "I",   "и": "i",   "Й": "Y",   "й": "y",   "К": "K",   "к": "k"
    "Л": "L",   "л": "l",   "М": "M",   "м": "m",   "Н": "N",   "н": "n"
    "О": "O",   "о": "o",   "П": "P",   "п": "p",   "Р": "R",   "р": "r"
    "С": "S",   "с": "s",   "Т": "T",   "т": "t",   "У": "U",   "у": "u"
    "Ф": "F",   "ф": "f",   "Х": "H",   "х": "h",   "Ц": "Ts",  "ц": "ts"
    "Ч": "Ch",  "ч": "ch",  "Ш": "Sh",  "ш": "sh",  "Щ": "Sch", "щ": "sch"
    "Ъ": "\"",  "ъ": "\"",  "Ы": "Y",   "ы": "y",   "Ь": "'",   "ь": "'"
    "Э": "E",   "э": "e",   "Ю": "Yu",  "ю": "yu",  "Я": "Ya",  "я": "ya"
  r = ""
  r += k for k of L
  r = new RegExp("[" + r + "]", "g")
  k = (a) -> if a of L then L[a] else ""
  return -> @replace(r, k)
)()


md2html = (->
  rexp = /^<p>(.*)<\/p>\s*$/
  (str) -> 
    console.log "md2html", str
    md = marked(str)
    if rexp.test(md) then RegExp.$1 else md
)()

event_short2full = (short) ->
  full = 
    _id:      short._id || _.guid()
    title:    short.title
    desc:     md2html(short.desc)
    date:     false
    verified: short.verified or no
    archived: short.archived or no
    updated:  new Date
    info:     []

  date = short.date || "invalid date"
  full.date = if moment(date).isValid() 
    moment(date).toDate()
  else if moment(date, "DD.MM.YY").isValid()
    moment(date, "DD.MM.YY").toDate()
  else if moment(date, "DD.MM.YYYY").isValid()
    moment(date, "DD.MM.YYYY").toDate()

  for key,val of short.info
    m = /^(user|place|time)?\s*(.*)$/.exec(key.trim())
    m[1] or= "user"
    info = 
      icon: m[1].toLowerCase()
      term: m[2].capitalize()
      desc: md2html(val)
    full.info.push(info)

  return full


event_full2short = (full) ->
  short = 
    title:    full.title
    desc:     toMarkdown(full.desc)
    date:     moment(full.date).format("DD.MM.YY")
    info:     {}
    verified: full.verified

  for info in full.info
    short.info["#{info.icon} #{info.term}"] = toMarkdown(info.desc)

  return short

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


class Event extends Model

  url: "events"
  idAttribute: "_id"

  constructor: (data) ->
    super
    console.log "constructor", data
    if data._id
      @data = data
    else
      @data = 
        _id:       _.guid()
        title:    data.title
        desc:     md2html(data.desc)
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

      for key,val of data.info
        m = /^(user|place|time)?\s*(.*)$/.exec(key.trim())
        m[1] or= "user"
        info = 
          icon: m[1].toLowerCase()
          term: m[2].capitalize()
          desc: md2html(val)
        @data.info.push(info)

    @attributes = @data
    console.log @data

  uniqName: ->
    name = @data.title.translit()
    name += if @data.date
      "-" + moment(@data.date).format("DD.MM.YY")
    else
      "_" + moment(@data.updated).format("DD.MM.YY")
    return name



class EventList extends Collection
  model: Event
  url: "events"

  parse: (data, options) =>
    console.log "parse", arguments
    return data



class UIEventList extends UIView
  @registerClass(@name)

  events: 
    "click .create-new-btn": "on_createNewBtnClick"
    "click .save-btn": "on_saveBtnClick"

  constructor: ->
    super

    @editor = CodeMirror.fromTextArea @$(".editor")[0], 
      mode: "text/x-yaml"
      theme: "monokai"
      tabSize: 2
      lineWrapping: yes
      extraKeys:
        Tab: (cm)->
          console.log "tab"
          unless cm.getSelection().length
            cm.replaceSelection("  ", "end")
        "Cmd-S": (cm) =>
          @_saveToLS()
    @editor.setValue(localStorage["autosave"] || "")
    @items = []
    @itemsEl = @$(".items")
    @itemsEl.empty()
    @collection = new EventList
    @collection.fetch(success: @on_featchSuccess, error: @on_featchError)


  _saveToLS: =>
    localStorage["autosave"] = @editor.getValue()


  on_createNewBtnClick: (e) =>
    console.log "on_createNewBtnClick"
    @trigger("create-new")
    @editor.setValue '''
title: 
desc: 
date: 
info: 
  user Организатор: 
  time Время выезда: 
verified: false
'''


  on_saveBtnClick: (e) =>
    yaml = @editor.getValue()
    obj = {}
    try
      obj = jsyaml.load(yaml)
      @trigger("save", obj)
      console.log ev = new Event(obj)
      @editor.setValue(jsyaml.dump(event_full2short(ev.data)))
      console.log JSON.stringify(ev.data)
      ev.save()
      item = new UIEventView(model: ev)
      @itemsEl.append(item.render())
      item.on("click", @on_itemClick)
      @items.push(item)
    catch e
      @$(".message").text(e).css(color: "red")

  on_itemClick: (item) =>
    @selected = item
    @trigger("item-select", item)
    @editor.setValue(jsyaml.dump(event_full2short(item.model.data)))

  on_featchSuccess: (self, data) =>
    console.log "on_featchSuccess", @collection.models
    @collection.each (model) =>
      item = new UIEventView(model: model)
      @itemsEl.append(item.render())
      item.on("click", @on_itemClick)
      @items.push(item)



  on_featchError: =>
    console.log "featch error"



class UIEventView extends UIView
  @registerClass(@name)
  tagName: "tr"

  template: '''
    <td><%= name %></td>
    <td><%= title %></td>
    <td><%= date %></td>
    <td><%- desc %></td>
  '''

  events: 
    "click": "on_click"

  constructor: -> 
    super

  render: =>
    args =
      name: @model.uniqName()
      title: @model.get("title")
      date: moment(@model.get("date")).format("DD.MM.YY")
      desc: md2html(@model.get("desc"))
    tpl = _.template(@template, args)
    @$el.html(tpl)
    return @$el

  on_click: (e) =>
    @trigger("click", this)


class EventsEditorApp extends Application

  constructor: (options) ->
    super
    @on("load", @on_load)
    @on("loaded", @on_loaded)

  on_load: =>
    console.log "Hello"
    @initAutoloadObjects() 

  on_loaded: =>
    # bindEvents
    #   "event-list item-select": "editor switch2json"
    #   "event-list create-new": "editor switch2coffee"

window.app = new EventsEditorApp