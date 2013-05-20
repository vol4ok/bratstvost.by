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

  sock = io.connect('http://vol4ok.com:3000' + _.result(model, 'url'))
  sock.emit method, model, (err, data) ->
    console.log "sync-complete", err, data
    unless err
      options.success(data)
    else
      options.error(data)