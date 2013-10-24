configure = ($routeProvider, $locationProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $routeProvider
    .when "/",
      templateUrl: "index-view"
      controller: "IndexPageCtrl"
    .when "/contacts",
      templateUrl: "contact-view"
    .when "/about",
      templateUrl: "about-view"
      controller: "AboutPageCtrl"

main = (DATA) ->
  window.DATA = DATA

angular.module('app.ctrl', [
  'NewsListCtrl'
  'EventListCtrl'
  'NoticeListCtrl'
  'IndexPageCtrl'
  'AboutPageCtrl'
])

angular.module('app.div', [
  'EventViewDiv'
  'ArchiveCollapsDiv'
])

angular.module('app.svc', [
  'EventsSvc'
  'NoticeSvc'
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