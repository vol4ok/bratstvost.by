class EventsSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()

    @$http.get('/api/events')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()

    return deffered.promise;


angular.module("EventsSvc", []).service("EventsSvc", ["$q", "$http", EventsSvc])