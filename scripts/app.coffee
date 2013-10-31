configure = ($routeProvider, $locationProvider, $sceDelegateProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $sceDelegateProvider.resourceUrlWhitelist(['^(?:http(?:s)?:\/\/)?(?:[^\.]+\.)?\(vimeo|youtube)\.com(/.*)?$', 'self'])

  $routeProvider
    .when "/",
      templateUrl: "index-view"
      controller: "IndexPageCtrl"
    .when "/contacts",
      templateUrl: "contact-view"
    .when "/about",
      templateUrl: "about-view"
      controller: "AboutPageCtrl"
    .when "/video",
      templateUrl: "video-view"
      controller: "VideoPageCtrl"

main = (DATA) ->
  window.DATA = DATA

angular.module('app.ctrl', [
  'NewsListCtrl'
  'EventListCtrl'
  'NoticeListCtrl'
  'IndexPageCtrl'
  'AboutPageCtrl'
  'VideoPageCtrl'
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
  .config([ '$routeProvider', '$locationProvider', '$sceDelegateProvider', configure ])
  .run(["DATA", main])