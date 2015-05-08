configure = ($routeProvider, $locationProvider, $sceDelegateProvider, $sceProvider) ->
  moment.lang('ru')

  $locationProvider
    .html5Mode(yes)

  $sceProvider.enabled(false)

  $routeProvider
    .when "/",
      templateUrl: "index-view"
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
    .when "/life-of-saint-Spyridon",
      templateUrl: "story-view"
    .when "/news",
      templateUrl: "news-view"
      controller: "NewsListCtrl"
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
  'PastEventCtrl'
  'AboutPageCtrl'
  'ContactPageCtrl'
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