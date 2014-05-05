angular.module('coreLibs', [])

$core = ($rootScope, 
         $coreEvents, 
         $coreNews, 
         $coreNotices, 
         $coreVideo
         $coreMembers) -> 

  $core.$inject = [
    "$rootScope" 
    "$coreEvents"
    "$coreNews"
    "$coreNotices"
    "$coreVideo"
    "$coreMembers"
  ]
  
  exports =
    $events:  $coreEvents
    $videos:  $coreVideo
    $news:    $coreNews
    $notices: $coreNotices
    $members: $coreMembers
  
  $rootScope.$core = exports
  window._$core = exports
  
  return exports

angular.module('core', ['coreLibs']).factory "$core", $core