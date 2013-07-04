class UIView extends Backbone.View
  constructor: ->
    super
    @registerObject(@id or @$el.attr("id") or @cid)




class Application extends Backbone.Router

  bindEvent: (src, trg) =>
    $$ = Backbone.getObjectByName
    [srcObj, event]  = if (t = src.split(' ')).length is 1 then [this, t[0]] else [$$(t[0]), t[1]]
    [trgObj, method] = if (t = trg.split(' ')).length is 1 then [this, t[0]] else [$$(t[0]), t[1]]
    srcObj.on(event, trgObj[method])

  bindEvents: (events) =>
    return unless events
    for src, trg of events
      @bindEvent(src, trg)

  constructor: ->
    @cid ?= "app"
    super
    Backbone.registerObject(@cid, this)
    window.$trigger = _.bind(@trigger, this)
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
    $trigger("modal-show", this)
    callback?()

  hide: (callback) =>
    @$el.removeClass("active")
    @trigger("hide")
    $trigger("modal-hide", this)
    callback?()    

  on_close: (e) => 
    @trigger("close")

  on_click: =>
    @trigger("close")    

  on_modalClick: (e) =>
    e.stopPropagation()




#################                        #################
##############          NEWS VIEWS          ##############
###########                                    ###########




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






#################                  #################
##############          LIST          ##############
###########                              ###########


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




#################                  #################
##############          MODALS        ##############
###########                              ###########


class UIVideoModal extends UIModal
  @registerClass(@name)

  template: "#picture-video-template"

  constructor: ->
    super
    @template = _.template(@$(@template).text())
    @on("close", @on_close)

  show: (view) =>
    unless @currentId is view.model._id
      @$el.empty().html(@template(view.model))
      @currentId = view.model._id
    super

  on_close: =>
    @hide()



class UIPictureModal extends UIModal
  @registerClass(@name)

  template: "#picture-modal-template"

  constructor: ->
    super
    @template = _.template(@$(@template).text())
    @on("close", @on_close)

  show: (view) =>
    unless @currentId is view.model._id
      @$el.empty().html(@template(view.model))
      @$('#slider').flexslider
        animation: "slide"
        controlNav: off
        slideshow: off
      @currentId = view.model._id
    super

  on_close: =>
    @hide()




#################               #################
##############          APP        ##############
###########                           ###########


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
    @bindEvents
      "news-list show-video": "video-modal show"
      "news-list show-picture": "picture-modal show"
      "modal-show": "page blur"
      "modal-hide": "page unblur"

window.app = new MyApp
