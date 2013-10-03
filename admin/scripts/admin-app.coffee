configure = ($routeProvider, $locationProvider) ->
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
    .when "/ads",
      templateUrl: "ads-view"

main = () ->
  console.log "initialize adminApp"

angular.module('adminApp.ctrl', [
  "EventEditorCtrl"
])
angular.module('adminApp.div', [

])

angular.module('adminApp.svc', [
  "EventsSvc"
])

angular.module('adminApp', [
    'ngSanitize'
    'ngRoute'
    'adminApp.ctrl'
    # 'app.div'
    'adminApp.svc'
    # 'app.data'
  ])
  .config([ '$routeProvider', '$locationProvider', configure ])
  .run([main])