class NewsListCtrl

  constructor: (@$scope, @$newsSvc) ->
    @$newsSvc.all().then (news) =>
      @$scope.data = {}
      @$scope.data.news = news

      @$scope.data.news.sort (a,b) -> 
        moment(b.date).valueOf() - moment(a.date).valueOf()

      for news in @$scope.data.news
        news.timeAgo = moment(news.date).fromNow()

angular.module("NewsListCtrl", ["NewsSvc"]).controller("NewsListCtrl",  ["$scope", "NewsSvc", NewsListCtrl])