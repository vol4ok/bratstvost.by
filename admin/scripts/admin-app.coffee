configure = ($routeProvider, $locationProvider, $httpProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $routeProvider
    .when "/",
      templateUrl: "index-view"
    .when "/events",
      templateUrl: "events-view"
    .when "/news",
      templateUrl: "news-view"
    .when "/notices",
      templateUrl: "notices-view"

main = () ->
  console.log "initialize adminApp"

angular.module('adminApp.ctrl', [
  "EventEditorCtrl"
  "NoticeEditorCtrl"
  "NewsEditorCtrl"
])
angular.module('adminApp.div', [

])

angular.module('adminApp.svc', [
  "EventsSvc"
  "NoticeSvc"
  "NewsSvc"
])

angular.module('adminApp', [
    'ngSanitize'
    'ngRoute'
    'adminApp.ctrl'
    'adminApp.svc'
  ])
  .config([ '$routeProvider', '$locationProvider', '$httpProvider', configure ])
  .run([main])