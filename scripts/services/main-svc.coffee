class MainSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()

    @$http.get('/api/main')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()

    return deffered.promise


angular.module("MainSvc", []).service("MainSvc", ["$q", "$http", MainSvc])