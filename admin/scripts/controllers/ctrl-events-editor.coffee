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
 
  saveCurrentEvent: =>
    console.log @$scope.data.currentEvent
    ev = @$scope.data.currentEvent
    @$scope.data.isNew = yes unless ev._id
    ev._id ?= uuid.v4()
    ev.updated ?= moment().toISOString()
    ev.created ?= moment().toISOString()
    ev.type ?= "event"
    ev.custom_field ?= []
    if @$scope.data.isNew
      @$eventsSvc.create(ev).then (resp) =>
        console.log resp
    else
      @$eventsSvc.save(ev).then (resp) =>
        console.log resp
    @$scope.data.events[ev._id] = ev;
      



  constructor: (@$scope, @$eventsSvc) ->

    @$scope.data = {}
    @$scope.selectEvent = @selectEvent
    @$scope.createEvent = @createEvent
    @$scope.saveCurrentEvent = @saveCurrentEvent


    @$eventsSvc.all().then (events) =>
      @$scope.data.events = {}
      for ev in events
        @$scope.data.events[ev._id] = ev

    @$scope.$watch "data.currentEvent._id", =>
      console.log '$watch "data.currentEvent._id"'
      @$scope.data.currentEventJSON = JSON.stringify(@$scope.data.currentEvent , null, "  ")

    @$scope.$watch "data.currentEventJSON", =>
      console.log '$watch "data.currentEventJSON"'
      try
        @$scope.data.currentEvent = JSON.parse(@$scope.data.currentEventJSON)
      catch
        # ...

      

angular.module("EventEditorCtrl", ["EventsSvc"])
  .controller("EventEditorCtrl", ["$scope", "EventsSvc", EventEditorCtrl])
