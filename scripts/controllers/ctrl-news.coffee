class NewsCtrl

  constructor: (@$rootScope, @$scope, @$routeParams, @$newsSvc) ->
    newsId = @$routeParams.newsId

    @$newsSvc.byId(newsId).then (oneNews) =>
      oneNews.timeAgo = moment(oneNews.date).fromNow()
      @$scope.oneNews = oneNews

    $rootScope.ogDesc = "No way back: Почему я перешел с Java на"

angular.module("NewsCtrl", ["NewsSvc"]).controller("NewsCtrl",  ["$rootScope","$scope", "$routeParams", "NewsSvc", NewsCtrl])