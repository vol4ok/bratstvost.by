class NewsSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()
    @$http.get('/api/news')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;

  create: (doc) ->
    deffered = @$q.defer()
    @$http.post('/api/news', doc)
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;

  save: (id, doc) ->
    if arguments.length is 1
      doc = id
      id = doc._id
    console.log "AD_SVC: save", id, doc
    deffered = @$q.defer()
    doc.updated = moment().toISOString()
    @$http.put("/api/news/#{id}", doc)
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;

  delete: (id) ->
    deffered = @$q.defer()
    @$http.delete("/api/news/#{id}")
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;


angular.module("NewsSvc", []).service("NewsSvc", ["$q", "$http", NewsSvc])