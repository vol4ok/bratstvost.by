$coreVideo = ($q, $http) ->
  $coreVideo.$inject = ["$q", "$http"]

  console.log "init $coreVideo"
  currentCollection = []
  currentItem = null

  return {
    all: () ->
      deffered = $q.defer()

      $http.get('/api/videos')
        .success (data, status, headers, config) => 
          deffered.resolve(data)
        .error (data, status, headers, config) => 
          deffered.reject()

      return deffered.promise
  }


angular.module('coreLibs').factory "$coreVideo", $coreVideo