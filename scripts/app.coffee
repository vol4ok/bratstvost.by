configure = ($routeProvider, $locationProvider, $sceDelegateProvider, $sceProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $sceProvider.enabled(false)

  $routeProvider
    .when "/",
      templateUrl: "index-view"
    .when "/2",
      templateUrl: "index-view2"
      controller: "IndexPage2Ctrl"
    .when "/contacts",
      templateUrl: "contact-view"
      controller: "ContactPageCtrl"
    .when "/about",
      templateUrl: "about-view"
      controller: "AboutPageCtrl"
    .when "/members",
      templateUrl: "members-view"
      controller: "MembersPageCtrl"
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
    .when "/become-a-volunteer",
      templateUrl: "become-a-volunteer-view"
    .when "/donations",
      templateUrl: "donations-view"
    .when "/how-to-help",
      templateUrl: "how-to-help-view"

    # .when "/event/:id",
    #   templateUrl: "event-view"
    #   controller: "EventViewCtrl"

main = () ->

angular.module('appLibs', [])

angular.module('app.ctrl', [
  'MainCtrl'
  'NewsListCtrl'
  'EventListCtrl'
  'AboutPageCtrl'
  'ContactPageCtrl'
  'ArticlePageCtrl'
  'StoryPageCtrl'
  'NewsPageCtrl'
  'CalendarPartCtrl'
  'BirthdayPartCtrl'
])

angular.module('app.div', [
  'EventViewDiv'
  'TabDivs'
])

angular.module('app.svc', [
  'EventsSvc'
  'MainSvc'
  'NewsSvc'
  'ArticleSvc'
])

angular.module('app', [
    'ngSanitize'
    'ngRoute'
    'ui.bootstrap.tpls'
    'ui.bootstrap'
    'core'
    'appLibs'
    'app.ctrl'
    'app.div'
    'app.svc'
  ])
  .config([ '$routeProvider', '$locationProvider', '$sceDelegateProvider', '$sceProvider', configure ])
  .run(["$core", main])