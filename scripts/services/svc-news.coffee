class NewsSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()

    @$http.get('/api/news')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()

    return deffered.promise


angular.module("NewsSvc", []).service("NewsSvc", ["$q", "$http", NewsSvc])