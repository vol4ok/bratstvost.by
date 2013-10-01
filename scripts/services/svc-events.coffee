class EventsSvc

  constructor: (@$q) ->


  on_getEventsSuccess:  =>


  on_getEventsFail: (data, status, headers, config) =>

  all: () ->
    deffered = @$q.defer()

    $http.get('/api/events')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()


angular.module("EventsSvc", []).service("EventsSvc", ["$q", EventsSvc])