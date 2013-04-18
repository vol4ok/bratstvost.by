__objects = {}
__classes = {}
__templates = {}
__engine = (src, locals, partials) -> src
__loaded = false
  
registerObject = (id, object)  -> __objects[id]   = object
registerClass  = (name, klass) -> __classes[name] = klass
registerObjects = (hash) -> __objects[id]   = obj for id, obj of hash
registerClasses = (hash) -> __classes[name] = klass for name, klass of hash
$$ = getObjectById = (id) -> __objects[id]
getClassByName = (name) -> __classes[name]

registerTemplate = (name, template) -> __templates[name] = template
registerTemplateEngine = (engine) -> __engine = engine
$T = renderTemplate = (name, locals, partials) -> __engine(__templates[name], locals, partials)

initialize = ->
  $ -> __loaded = yes; $.emit('load')
  $.on 'load', -> $.defer -> $.emit('loaded')
  _on = $.on
  $.on = (event, handler) ->
    if (event == "load" or event == "loaded") and __loaded
      handler()
    else
      _on.apply(this, arguments)

$.extend exports, {
  registerObject
  registerClass
  registerObjects
  registerClasses
  getObjectById
  getClassByName
  registerTemplate
  registerTemplateEngine
  renderTemplate
  $$
  $T
  __objects
  __classes
  __templates
}

initialize()