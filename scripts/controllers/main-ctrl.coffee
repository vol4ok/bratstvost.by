class MainCtrl

  constructor: (@$scope, @$mainSvc) ->
    @$mainSvc.all().then (data) =>

      @$scope.notices = data.notices
      @$scope.notices.sort (a,b) -> b.priority - a.priority

      @$scope.anews = data.news

#      @$scope.news.sort (a,b) ->
#        moment(b.date).valueOf() - moment(a.date).valueOf()

      for news in @$scope.anews
        news.timeAgo = moment(news.date).fromNow()


angular.module("MainCtrl",["MainSvc"]).controller("MainCtrl", ["$scope", "MainSvc", MainCtrl])