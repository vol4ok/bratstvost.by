configure = ($routeProvider, $locationProvider, $sceDelegateProvider, $sceProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  #$sceDelegateProvider.resourceUrlWhitelist(['self','^(?:http(?:s)?:\/\/)?(?:[^\.]+\.)?\(vimeo|youtube)\.com(/.*)?$'])
  $sceProvider.enabled(false)

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
    .when "/members",
      templateUrl: "members-view"
      controller: "AboutPageCtrl"
    .when "/video",
      templateUrl: "video-view"
      controller: "VideoPageCtrl"
    .when "/article/:id",
      templateUrl: "article-view"
      controller: "ArticlePageCtrl"
    .when "/life-of-saint-Spyridon",
      templateUrl: "story-view"
      controller: "StoryPageCtrl"
    .when "/news",
      templateUrl: "news-view"
      controller: "NewsPageCtrl"

main = () ->

angular.module('app.ctrl', [
  'NewsListCtrl'
  'EventListCtrl'
  'NoticeListCtrl'
  'IndexPageCtrl'
  'AboutPageCtrl'
  'VideoPageCtrl'
  'ContactPageCtrl'
  'ArticlePageCtrl'
  'StoryPageCtrl'
  'NewsPageCtrl'
])

angular.module('app.div', [
  'EventViewDiv'
  'ArchiveCollapsDiv'
  'NavigationDivs'
  'TabDivs'
])

angular.module('app.svc', [
  'EventsSvc'
  'NoticeSvc'
  'NewsSvc'
  'ArticleSvc'
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
  .config([ '$routeProvider', '$locationProvider', '$sceDelegateProvider', '$sceProvider', configure ])
  .run()