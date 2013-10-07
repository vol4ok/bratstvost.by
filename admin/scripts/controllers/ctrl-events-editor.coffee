class EventEditorCtrl

  selectEvent: (ev) =>
    @$scope.data.isNew = no
    @$scope.data.currentEvent = ev

  createEvent: =>
    @$scope.data.isNew = yes
    @$scope.data.currentEvent =
      _id:           uuid.v4()
      date:          moment().add(1,'d').format("YYYY-MM-DD")
      title:         ""
      body:          ""
      event_time:    ""
      event_place:   ""
      meeting_time:  ""
      meeting_place: ""
      organizer:     ""
      phone:         ""
      cost:          ""
      published:     true
      updated:       moment().toISOString()
      created:       moment().toISOString()
      type:          "event"

  deleteCurrentEvent: () =>
    if confirm("Точно удалить?")
      @$eventsSvc.delete(@$scope.data.currentEvent._id).then (resp) =>
        console.log resp
      delete @$scope.data.events[@$scope.data.currentEvent._id]
      @updateEventsArray()
      @$scope.data.currentEvent = @$scope.data.eventsArr[0]


  saveEvent: (ev) =>
    @$scope.data.isNew = yes unless ev._id
    ev._id ?= uuid.v4()
    ev.updated ?= moment().toISOString()
    ev.created ?= moment().toISOString()
    ev.type ?= "event"
    ev.custom_field ?= []
    console.log "saveEvent", ev
    if @$scope.data.isNew
      @$eventsSvc.create(ev).then (resp) =>
        console.log resp
    else
      @$eventsSvc.save(ev).then (resp) =>
        console.log resp
    @$scope.data.events[ev._id] = ev;
    @updateEventsArray()
 
  saveCurrentEvent: =>
    if angular.isArray(@$scope.data.currentEvent)
      last = null
      @$scope.data.isNew = yes
      for ev in @$scope.data.currentEvent
        @saveEvent(ev)
        last = ev
      @$scope.data.currentEvent = last
    else
      @saveEvent(@$scope.data.currentEvent)
      
  updateEventsArray: =>
    result = []
    for k,v of @$scope.data.events
      result.push(v)
    result.sort (a,b) -> moment(b.date).valueOf() - moment(a.date).valueOf()
    @$scope.data.eventsArr = result

  constructor: (@$scope, @$eventsSvc) ->
    @$scope.data = {}
    @$scope.selectEvent = @selectEvent
    @$scope.createEvent = @createEvent
    @$scope.saveCurrentEvent = @saveCurrentEvent
    @$scope.deleteCurrentEvent = @deleteCurrentEvent


    @$eventsSvc.all().then (events) =>
      @$scope.data.events = {}
      for ev in events
        @$scope.data.events[ev._id] = ev
      @updateEventsArray()

    @$scope.$watch "data.currentEvent._id", (value) =>
      console.log '$watch "data.currentEvent._id"'
      return if angular.isArray(@$scope.data.currentEvent)
      @$scope.data.currentEventJSON = JSON.stringify(@$scope.data.currentEvent , null, "  ")



    @$scope.$watch "data.currentEventJSON", =>
      console.log '$watch "data.currentEventJSON"'
      try
        @$scope.data.currentEvent = JSON.parse(@$scope.data.currentEventJSON)
      catch
        # ...

      

angular.module("EventEditorCtrl", ["EventsSvc"])
  .controller("EventEditorCtrl", ["$scope", "EventsSvc", EventEditorCtrl])
