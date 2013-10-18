class NoticeSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()

    @$http.get('/api/notice')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()

    return deffered.promise


angular.module("NoticeSvc", []).service("NoticeSvc", ["$q", "$http", NoticeSvc])