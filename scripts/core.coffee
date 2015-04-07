angular.module('coreLibs', [])

$core = ($rootScope, 
         $coreVideo
         $coreMembers) -> 

  $core.$inject = [
    "$rootScope" 
    "$coreVideo"
    "$coreMembers"
  ]
  
  exports =
    $videos:  $coreVideo
    $members: $coreMembers
  
  $rootScope.$core = exports
  window._$core = exports
  
  return exports

angular.module('core', ['coreLibs']).factory "$core", $core