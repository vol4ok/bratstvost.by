Backbone.__classes = {}
Backbone.__objects = {}
Backbone.registerClass = Backbone.View.registerClass = (name, klass=this) -> Backbone.__classes[name] = klass
Backbone.getClassByName = (name) -> Backbone.__classes[name]

Backbone.registerObject = Backbone.View::registerObject = (name, obj=this) -> Backbone.__objects[name] = obj
Backbone.getObjectByName = Backbone.View::getObjectByName = (name) -> Backbone.__objects[name]


# Backbone.sync = (method, model, options) ->
#   console.log "sync", method.toUpperCase, model, options

#   sock = io.connect('http://vol4ok.com:3000' + _.result(model, 'url'))
#   sock.emit method, model, (err, data) ->
#     console.log "sync-complete", err, data
#     unless err
#       options.success(data)
#     else
#       options.error(data)