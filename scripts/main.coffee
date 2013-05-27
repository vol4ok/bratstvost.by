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

##################################
###################################
####################################


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


class UIModal extends UIView
  @registerClass(@name)

  events: 
    "click .x": "on_close"
    "click": "on_click"
    "click .modal": "on_modalClick"

  constructor: (options) -> 
    super

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

  on_click: =>
    @trigger("close")    

  on_modalClick: (e) =>
    e.stopPropagation()


class UIVideoModal extends UIModal
  @registerClass(@name)

class UIButton extends UIView
  @registerClass(@name)

  events:
    "click": "on_click"

  constructor: (options) -> super

  on_click: (e) -> 
    @trigger("click")

class MyApp extends Application

  constructor: (options) -> 
    super
    @on("load", @on_load)
    @on("loaded", @on_loaded)

  on_load: => 
    console.log "Hello"
    @initAutoloadObjects() 
    moment.lang("ru")
    $(".event-short").click (e) -> 
      $(this)
        .parent()
        .find(".event-more")
        .toggleClass("active")
      $(this)
        .find(".event-state")
        .removeClass("new")
    console.log "laoding fancybox"
    $(".fb").fancybox
      maxWidth    : 800
      maxHeight   : 600
      fitToView   : false
      width       : '70%'
      height      : '70%'
      autoSize    : false
      closeClick  : false
      openEffect  : 'none'
      closeEffect : 'none'

  on_loaded: =>   
    bindEvents
      "new-button click": "modal-1 show"
      "modal-1 close": "modal-1 hide"
      "modal-1 show": "page blur"
      "modal-1 hide": "page unblur"

window.app = new MyApp
