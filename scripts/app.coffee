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
      controller: "ContactPageCtrl"
    .when "/about",
      templateUrl: "about-view"
      controller: "AboutPageCtrl"
    .when "/video",
      templateUrl: "video-view"
      controller: "VideoPageCtrl"

main = () ->

angular.module('app.ctrl', [
  'NewsListCtrl'
  'EventListCtrl'
  'NoticeListCtrl'
  'IndexPageCtrl'
  'AboutPageCtrl'
  'VideoPageCtrl'
  'ContactPageCtrl'
])

angular.module('app.div', [
  'EventViewDiv'
  'ArchiveCollapsDiv'
  'NavigationDivs'
])

angular.module('app.svc', [
  'EventsSvc'
  'NoticeSvc'
  'NewsSvc'
])

angular.module('app.ftr', [])

angular.module('app', [
    'ngSanitize'
    'ngRoute'
    'app.ftr'
    'app.ctrl'
    'app.div'
    'app.svc'
  ])
  .config([ '$routeProvider', '$locationProvider', '$sceDelegateProvider', configure ])
  .run()