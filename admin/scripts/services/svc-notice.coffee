class NoticeSvc

  constructor: (@$q, @$http) ->

  all: () ->
    deffered = @$q.defer()
    @$http.get('/api/notice')
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;

  create: (doc) ->
    deffered = @$q.defer()
    @$http.post('/api/notice', doc)
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
    @$http.put("/api/notice/#{id}", doc)
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;

  delete: (id) ->
    deffered = @$q.defer()
    @$http.delete("/api/notice/#{id}")
      .success (data, status, headers, config) => 
        deffered.resolve(data)
      .error (data, status, headers, config) => 
        deffered.reject()
    return deffered.promise;


angular.module("NoticeSvc", []).service("NoticeSvc", ["$q", "$http", NoticeSvc])