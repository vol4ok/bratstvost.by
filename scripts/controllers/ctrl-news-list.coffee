class NewsListCtrl

  constructor: (@$scope) ->
    data = angular.copy(DATA)

    @$scope.data = {}
    @$scope.data.news = DATA.news

    @$scope.data.news.sort (a,b) -> 
      moment(b.date).valueOf() - moment(a.date).valueOf()

    for news in @$scope.data.news
      news.timeAgo = moment(news.date).fromNow()

angular.module("NewsListCtrl",[]).controller("NewsListCtrl", ["$scope", NewsListCtrl])