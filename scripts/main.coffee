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
      el.removeAttribute("data-class")
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
    "click .modal-view": "on_modalClick"

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


class UIVideoNewsView extends UIView
  @registerClass(@name)

  events:
    "click": "on_click"

  constructor: ->
    super
    @videoId = @model.video.id

  on_click: =>
    @trigger("show-video", this)




class UITextNewsView extends UIView
  @registerClass(@name)


class UIPictureNewsView extends UIView
  @registerClass(@name)

  events:
    "click": "on_click"

  constructor: ->
    super

  on_click: =>
    @trigger("show-picture", this)


class UINewsList extends UIView
  @registerClass(@name)

  constructor: ->
    super
    @items = {}
    @_initNews()

  _initNews: ->
    for el in @$el.children()
      $el = $(el)
      klass = $el.data("class")
      continue unless klass

      model = null
      if $el.data("model")
        model = JSON.parse(Base64.decode($el.data("model")))
        el.removeAttribute("data-model")
        $el.removeData('model')
      el.removeAttribute("data-class")
      $el.removeData('class')

      nv = new (Backbone.getClassByName(klass))(el: el, model: model)
      nv.on "show-video", (view) =>
        @trigger("show-video", view)
      nv.on "show-picture", (view) =>
        @trigger("show-picture", view)
      @items[nv.id] = nv


class UIVideoModal extends UIModal
  @registerClass(@name)

  template: '''
    <iframe 
      width="<%= width %>" 
      height="<%= height %>" 
      src="http://www.youtube.com/embed/<%= videoId %>" 
      frameborder="0" 
      allowfullscreen>
    </iframe>
  '''

  constructor: ->
    super
    @cache = {}
    @$body = @$(".modal-body")
    @template = _.template(@template)
    @on("close", @on_close)

  show: (view) =>
    if @currVideoId
      @cache[@currVideoId].hide()

    @currVideoId = view.videoId
    if @cache[view.videoId]
      console.log "load from cache", view.videoId
      @cache[view.videoId].show()
    else
      html = @template
        videoId: view.videoId
        width: 480
        height: 360
      $html = $(html)
      @$body.append($html)
      @cache[view.videoId] = $html
      console.log "save to cache", view.videoId
          
    super

  on_close: =>
    @hide()

class UIPictureModal extends UIModal
  @registerClass(@name)

  constructor: ->
    super
    @on("close", @on_close)

  show: (view) =>
    super
    unless @isInit
      @$('#carousel').flexslider
        animation: "slide"
        controlNav: false
        animationLoop: false
        slideshow: false
        itemWidth: 220
        itemMargin: 5
        asNavFor: '#slider'

      @$('#slider').flexslider
        animation: "slide"
        controlNav: false
        animationLoop: false
        slideshow: false
        sync: "#carousel"

      @isInit = yes


  on_close: =>
    @hide()



# class UIButton extends UIView
#   @registerClass(@name)

#   events:
#     "click": "on_click"

#   constructor: (options) -> super

#   on_click: (e) -> 
#     @trigger("click")

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

  on_loaded: =>  
    bindEvents
      "news-list show-video": "video-modal show"
      "news-list show-picture": "picture-modal show"
      "video-modal show": "page blur"
      "video-modal hide": "page unblur"
      "picture-modal show": "page blur"
      "picture-modal hide": "page unblur"

window.app = new MyApp
