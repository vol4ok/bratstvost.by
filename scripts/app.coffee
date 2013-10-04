configure = ($routeProvider, $locationProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $routeProvider
    .when "/",
      templateUrl: "index-view"

main = (DATA) ->
  window.DATA = DATA

angular.module('app.ctrl', [
  'NewsListCtrl'
  'EventListCtrl'
  'AdsListCtrl'
])

angular.module('app.div', [
  'EventViewDiv'
  'ArchiveCollapsDiv'
])

angular.module('app.svc', [
  'EventsSvc'
])

angular.module('app', [
    'ngSanitize'
    'ngRoute'
    'app.ctrl'
    'app.div'
    'app.svc'
    'app.data'
  ])
  .config([ '$routeProvider', '$locationProvider', configure ])
  .run(["DATA", main])