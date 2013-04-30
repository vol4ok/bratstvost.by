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

  sock = io.connect('http://localhost:3000' + _.result(model, 'url'))
  sock.emit method, model, (err, data) ->
    console.log "sync-complete", err, data
    unless err
      options.success(data)
    else
      options.error(data)
    

String::capitalize = ->
    return this.substr(0, 1).toUpperCase() + this.substr(1).toLowerCase()

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

strip_md_rexp = /^<p>(.*)<\/p>\s*$/

name2ico = 
  user: "user"
  time: "time"
  place: "map-marker"

ico2name = 
  user: "user"
  time: "time"
  "map-marker": "place"

event_short2full = (short) ->
  full = 
    _id:       short._id || _.guid()
    title:     short.title
    desc:      marked(short.desc)
    date:      false
    verified:  short.verified or no
    archived:  short.archived or no
    published: short.published or no
    updated:   new Date
    info:      []

  date = short.date || "invalid date"
  if moment(date, "DD.MM.YY HH:mm").isValid()
    full.date = moment(date, "DD.MM.YY HH:mm").toDate()
    full.hasTime = yes
  else if moment(date, "DD.MM.YY").isValid()
    full.date = moment(date, "DD.MM.YY").toDate()
    full.hasTime = no

  console.log full.date

  for key,val of short.info
    m = /^(user|place|time)?\s*(.*)$/.exec(key.trim())
    m[1] or= "user"
    info = 
      icon: name2ico[m[1].toLowerCase()]
      term: m[2].capitalize()
      desc: md2html(val)
    if strip_md_rexp.test(info.desc)
      info.desc = RegExp.$1 
    full.info.push(info)

  return full


event_full2short = (full) ->
  short = 
    title:     full.title
    desc:      toMarkdown(full.desc)
    info:      {}
    verified:  full.verified
    published: full.published
    archived:  full.archived

  short.date = if full.hasTime
    moment(full.date).format("DD.MM.YY HH:mm") 
  else
    moment(full.date).format("DD.MM.YY") 

  for info in full.info
    short.info["#{ico2name[info.icon]} #{info.term}"] = toMarkdown(info.desc)

  return short



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 


class Event extends Model

  url: "/events"
  idAttribute: "_id"

  parse: (item, options) =>
    return item

  constructor: (data) ->
    super


class EventList extends Collection
  model: Event
  url: "/events"

  parse: (items, options) =>
    return items


class UIEventList extends UIView
  @registerClass(@name)

  NEW_EVENT_TEMPLATE = '''
    title: 
    desc: 
    date: 
    info: 
      user Организатор: 
      time Время выезда: 
    verified: no
    published: no
  '''

  events: 
    "click .create-new-btn": "on_createBtnClick"
    "click .save-btn": "on_saveBtnClick"
    "click .template-btn": "on_templateBtnClick"
    "click .reset-btn": "on_resetBtnClick"

  on_templateBtnClick: =>
    @editor.setValue(NEW_EVENT_TEMPLATE)

  on_resetBtnClick: =>
    @editor.setValue("")

  constructor: ->
    super

    @rawMode = false
    @items = []
    @currentItem = null

    @$itemsEl      = @$(".active-items")
    @$archItemsEl  = @$(".archived-items")
    @$modalEl      = @$('.editor-modal')
    @$modalMessage = @$(".modal-message")

    @editor = CodeMirror.fromTextArea @$(".editor")[0], 
      mode: "text/x-yaml"
      #theme: "monokai"
      tabSize: 2
      lineWrapping: yes
      extraKeys:
        Tab: (cm)->
          console.log "tab"
          unless cm.getSelection().length
            cm.replaceSelection("  ", "end")

    #@editor.on("blur", @_saveToLS)

    @collection = new EventList
    @collection.fetch(success: @on_featchSuccess, error: @on_featchError)

  on_featchSuccess: (self, data) =>
    console.log "on_featchSuccess", @collection.models
    @collection.each(@_createItem)

  on_featchError: =>
    console.log "featch error"

  _saveToLS: =>
    localStorage["autosave"] = @editor.getValue()

  _setModalTitle: (title) =>
    @$modalTitleEl ?= @$('.modal-title')
    @$modalTitleEl.text(title)

  _createItem: (model) =>
    item = new UIEventView(model: model)
    if model.get("archived")
      @$archItemsEl.append(item.render())
    else
      @$itemsEl.append(item.render())
    item.on("dblclick",  @on_updateItem)
    item.on("update",    @on_updateItem)
    item.on("remove",    @on_removeItem)
    item.on("publish",   @on_publishItem)
    item.on("unpublish", @on_unpublishItem)
    @items[model.id] = item
    return item

  refresh: =>
    for id, item of @items when @items.hasOwnProperty(id)
      item.$el.detach()
      if item.model.get("archived")
        @$archItemsEl.append(item.render())
      else
        @$itemsEl.append(item.render())

  on_publishItem: (item) =>
    item.model.save {published: yes}, 
      success: => item.published()
      error: @on_saveError

    @refresh()

  on_unpublishItem: (item) => 
    item.model.save {published: no}, 
      success: => item.unpublished()
      error: @on_saveError
    @refresh()


  on_createBtnClick: (e) =>
    @$modalMessage.text("")
    @_setModalTitle("Create event")
    @currentItem = null
    @editor.setValue(localStorage["autosave"] || NEW_EVENT_TEMPLATE)
    @$modalEl.modal('show')


  on_updateItem: (item) =>
    @$modalMessage.text("")
    @_setModalTitle("Update event")
    @currentItem = item
    @editor.setValue(jsyaml.dump(event_full2short(item.model.attributes)))
    @$modalEl.modal('show')
    @editor.refresh()

  on_removeItem: (item) =>
    item.$el.remove()
    item.model.destroy()


  on_saveBtnClick: (e) =>
    try
      val = @editor.getValue()
      obj = if @rawMode
        JSON.parse(val)
      else
        event_short2full(jsyaml.load(val))
      if @currentItem
        delete obj._id
        if moment(obj.date).startOf('day') < moment().startOf('day')
          obj.archived = yes
        else
          obj.archived = no
        @currentItem.model.save(obj, {success: @on_saveSuccess, error: @on_saveError})
        @refresh()
        @$modalEl.modal('hide')
        @$modalMessage.text("")
      else
        ev = new Event(obj)
        @currentItem = @_createItem(ev)
        ev.save({}, {success: @on_saveSuccess, error: @on_saveError})
        @$modalEl.modal('hide')
        @$modalMessage.text("")
    catch e
      @$modalMessage.text(e).css(color: "red")

  on_saveSuccess: (model, resp, options) =>
    console.log "save success", model, resp, options

  on_saveError: =>
    console.log "save error"


  on_itemClick: (item) =>
    @selected = item
    @trigger("item-select", item)
    @editor.setValue(jsyaml.dump(event_full2short(item.model.data)))



class UIEventView extends UIView
  @registerClass(@name)
  tagName: "tr"

  events: 
    "dblclick": "on_dblclick"
    "click .edit-btn": "on_editBtnClick"
    "click .remove-btn": "on_removeBtnClick"
    "click .publish-btn": "on_publishBtnClick"

  template: "UIEventView-template"

  constructor: -> 
    super
    if _.isString(@template)
      @template = _.template($("##{@template}").html())

  render: =>
    mdate = moment(@model.get("date")).lang('en')
    args =
      title: @model.get("title")
      published: @model.get("published")
      date: if @model.get("hasTime")
        "#{mdate.format("D MMMM")}, <b>#{mdate.format("HH:mm")}</b>" 
      else
        mdate.format("D MMMM") 
    tpl = @template(args)
    @$el.html(tpl)
    @$el.attr("id", @model.id)
    return @$el

  published: =>
    @$(".publish-btn").addClass("active")

  unpublished: =>
    @$(".publish-btn").removeClass("active")

  on_dblclick: (e) =>
    @trigger("dblclick", this)

  on_editBtnClick: =>
    @trigger("update", this)

  on_removeBtnClick: =>
    @trigger("remove", this)

  on_publishBtnClick: (e) =>
    if @$(".publish-btn").hasClass("active")
      @trigger("unpublish", this)
    else
      @trigger("publish", this)






# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 



news_short2full = (short) ->
  full = 
    _id:        short._id || _.guid()
    title:      short.title
    short_body: marked(short.short)
    full_body:  marked(short.full)
    date:       false
    published:  short.published or no
    updated:    new Date

  date = short.date || "invalid date"
  if moment(date, "DD.MM.YY").isValid()
    full.date = moment(date, "DD.MM.YY").toDate()

  return full


news_full2short = (full) ->
  short = 
    title:     full.title
    short:     toMarkdown(full.short_body)
    full:      toMarkdown(full.full_body)
    published: full.published
    date:      moment(full.date).format("DD.MM.YY")
     
  return short



class News extends Model

  url: "/news"
  idAttribute: "_id"

  parse: (item, options) =>
    return item

  constructor: (data) ->
    super


class NewsList extends Collection
  model: News
  url: "/news"

  parse: (items, options) =>
    return items



class UINewsList extends UIView
  @registerClass(@name)

  NEW_EVENT_TEMPLATE = '''
    title: 
    short: 
    full: 
    date: 
    published: false
  '''

  events: 
    "click .create-new-btn": "on_createBtnClick"
    "click .save-btn": "on_saveBtnClick"
    "click .template-btn": "on_templateBtnClick"
    "click .reset-btn": "on_resetBtnClick"

  constructor: ->
    super

    @rawMode = false
    @items = []
    @currentItem = null

    @$itemsEl      = @$(".items")
    @$modalEl      = @$('.editor-modal')
    @$modalMessage = @$(".modal-message")

    @editor = CodeMirror.fromTextArea @$(".editor")[0], 
      mode: "text/x-yaml"
      #theme: "monokai"
      tabSize: 2
      lineWrapping: yes
      extraKeys:
        Tab: (cm)->
          console.log "tab"
          unless cm.getSelection().length
            cm.replaceSelection("  ", "end")

    @collection = new NewsList
    @collection.fetch(success: @on_featchSuccess, error: @on_featchError)


  on_templateBtnClick: =>
    @editor.setValue(NEW_EVENT_TEMPLATE)

  on_resetBtnClick: =>
    @editor.setValue("")

  on_featchSuccess: (self, data) =>
    console.log "on_featchSuccess", @collection.models
    @collection.each(@_createItem)

  on_featchError: =>
    console.log "featch error"

  _saveToLS: =>
    localStorage["autosave"] = @editor.getValue()

  _setModalTitle: (title) =>
    @$modalTitleEl ?= @$('.modal-title')
    @$modalTitleEl.text(title)

  _createItem: (model) =>
    item = new UINewsView(model: model)
    @$itemsEl.append(item.render())
    item.on("dblclick",  @on_updateItem)
    item.on("update",    @on_updateItem)
    item.on("remove",    @on_removeItem)
    item.on("publish",   @on_publishItem)
    item.on("unpublish", @on_unpublishItem)
    @items[model.id] = item
    return item

  refresh: =>
    for id, item of @items when @items.hasOwnProperty(id)
      item.$el.detach()
      @$itemsEl.append(item.render())

  on_publishItem: (item) =>
    item.model.save {published: yes}, 
      success: => item.render()
      error: @on_saveError
    @refresh()

  on_unpublishItem: (item) => 
    item.model.save {published: no}, 
      success: => item.render()
      error: @on_saveError
    @refresh()


  on_createBtnClick: (e) =>
    @$modalMessage.text("")
    @_setModalTitle("Create event")
    @currentItem = null
    @editor.setValue(localStorage["autosave"] || NEW_EVENT_TEMPLATE)
    @$modalEl.modal('show')


  on_updateItem: (item) =>
    @$modalMessage.text("")
    @_setModalTitle("Update event")
    @currentItem = item
    @editor.setValue(jsyaml.dump(news_full2short(item.model.attributes)))
    @$modalEl.modal('show')
    @editor.refresh()

  on_removeItem: (item) =>
    item.$el.remove()
    item.model.destroy()


  on_saveBtnClick: (e) =>
    try
      val = @editor.getValue()
      obj = if @rawMode
        JSON.parse(val)
      else
        news_short2full(jsyaml.load(val))
      if @currentItem
        delete obj._id
        @currentItem.model.save(obj, {success: @on_saveSuccess, error: @on_saveError})
        @refresh()
        @$modalEl.modal('hide')
        @$modalMessage.text("")
      else
        console.log "obj", obj
        news = new News(obj)
        console.log "news", news
        @currentItem = @_createItem(news)
        news.save({}, {success: @on_saveSuccess, error: @on_saveError})
        @$modalEl.modal('hide')
        @$modalMessage.text("")
    catch e
      @$modalMessage.text(e).css(color: "red")

  on_saveSuccess: (model, resp, options) =>
    console.log "save success", model, resp, options

  on_saveError: =>
    console.log "save error"


  on_itemClick: (item) =>
    @selected = item
    @trigger("item-select", item)
    @editor.setValue(jsyaml.dump(news_full2short(item.model.data)))



class UINewsView extends UIView
  @registerClass(@name)
  tagName: "tr"

  events: 
    "dblclick": "on_dblclick"
    "click .edit-btn": "on_editBtnClick"
    "click .remove-btn": "on_removeBtnClick"
    "click .publish-btn": "on_publishBtnClick"

  template: "UINewsView-template"

  constructor: -> 
    super
    if _.isString(@template)
      @template = _.template($("##{@template}").html())

  render: =>
    mdate = moment(@model.get("date")).lang('en')
    args =
      title: @model.get("title")
      published: @model.get("published")
      date: mdate.format("D MMMM")
    tpl = @template(args)
    @$el.html(tpl)
    @$el.attr("id", @model.id)
    return @$el

  on_dblclick: (e) =>
    @trigger("dblclick", this)

  on_editBtnClick: =>
    @trigger("update", this)

  on_removeBtnClick: =>
    @trigger("remove", this)

  on_publishBtnClick: (e) =>
    if @$(".publish-btn").hasClass("active")
      @trigger("unpublish", this)
    else
      @trigger("publish", this)




# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 





class EventsEditorApp extends Application

  constructor: (options) ->
    super
    @on("load", @on_load)
    @on("loaded", @on_loaded)

  on_load: =>
    console.log "Hello"
    @initAutoloadObjects()
    $('#pages a').click (e) ->
      e.preventDefault()
      $(this).tab('show')

  on_loaded: =>
    # bindEvents
    #   "event-list item-select": "editor switch2json"
    #   "event-list create-new": "editor switch2coffee"

window.app = new EventsEditorApp