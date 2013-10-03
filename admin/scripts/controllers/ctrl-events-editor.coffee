class EventEditorCtrl

  selectEvent: (ev) =>
    console.log "selectEvent", ev
    @$scope.data.currentEvent = ev
    @$scope.data.currentEventJSON = JSON.stringify(ev, null, "  ")


  constructor: (@$scope, @$eventsSvc) ->

    @$scope.data = {}
    @$scope.selectEvent = @selectEvent;


    @$eventsSvc.all().then (events) =>
      @$scope.data.events = events

angular.module("EventEditorCtrl", ["EventsSvc"])
  .controller("EventEditorCtrl", ["$scope", "EventsSvc", EventEditorCtrl])
