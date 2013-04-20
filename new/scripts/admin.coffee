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



class UIPage extends UIView
  @registerClass(@name)

  constructor: (options) -> super

  blur: (callback) =>
    @$el.addClass("blur")
    @trigger("blur")
    callback?()

  unblur: (callback) =>
    @$el.removeClass("blur")
    @trigger("unblur")
    callback?()



class UIPopupHolder extends UIView
  @registerClass(@name)

  constructor: (options) -> 
    super
    @popups = []
    @activePopups = 0
    @_initPopups()

  activate: (callback) =>
    @$el.addClass("active")
    @trigger("activate")
    callback?()

  deactivate: (callback) =>
    @$el.removeClass("active")
    @trigger("deactivate")
    callback?()

  _initPopups: =>
    for el, index in @$el.children()
      $el = $(el)
      popup = new (Backbone.getClassByName($el.data('class')))(el: $el)
      popup.on("show", @on_popupShow)
      popup.on("hide", @on_popupHide)
      @popups.push(popup)

  on_popupShow: =>
    @activate() if @activePopups++ == 0

  on_popupHide: =>
    @deactivate() if --@activePopups == 0

  on_click: (e) =>
    @trigger("click")



class UIPopupDialog extends UIView
  @registerClass(@name)

  events: 
    "click .x": "on_close"

  constructor: (options) -> 
    super
    @$el.find(".datepicker").datepicker(format: 'dd.mm.yyyy')

  show: (callback) =>
    @$el.addClass("active")
    @trigger("show")
    callback?()

  hide: (callback) =>
    @$el.removeClass("active")
    @trigger("hide")
    callback?()    

  on_close: (e) => 
    @trigger("close")


class UIButton extends UIView
  @registerClass(@name)

  events:
    "click": "on_click"

  constructor: (options) -> super

  on_click: (e) -> 
    @trigger("click")


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


class MyApp extends Application

  constructor: (options) -> 
    super
    @on("load", @on_load)
    @on("loaded", @on_loaded)

  on_load: => 
    console.log "Hello"
    @initAutoloadObjects() 

  on_loaded: =>   
    bindEvents
      "new-event-btn click": "new-event-popup show"
      "new-event-popup close": "new-event-popup hide"
      "popup-holder activate": "page blur"
      "popup-holder deactivate": "page unblur"

window.app = new MyApp
