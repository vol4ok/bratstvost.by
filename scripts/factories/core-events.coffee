$coreEvents = ($q, $http) ->
  $coreEvents.$inject = ["$q", "$http"]

  console.log "init $coreEvents"
  currentCollection = []
  currentItem = null

  return {
    all: () ->
      deffered = $q.defer()

      $http.get('/api/events')
        .success (data, status, headers, config) => 
          deffered.resolve(data)
        .error (data, status, headers, config) => 
          deffered.reject()

      return deffered.promise
  }


angular.module('coreLibs').factory "$coreEvents", $coreEvents