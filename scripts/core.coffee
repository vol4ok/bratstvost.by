angular.module('coreLibs', [])

$core = ($rootScope, $coreEvents, $coreVideo) -> 
  $core.$inject = ["$rootScope", "$coreEvents", "$coreVideo"]
  
  exports =
    $events: $coreEvents
    $videos: $coreVideo
  
  $rootScope.$core = exports
  window.$core = exports

  console.log "init $core"

  return exports

angular.module('core', ['coreLibs']).factory "$core", $core