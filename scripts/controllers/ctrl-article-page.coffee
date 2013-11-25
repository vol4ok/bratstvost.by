class ArticlePageCtrl

  formatDate: (date) ->
    moment(date).format("DD MMMM, YYYY")


  constructor: (@$scope, @$routeParams, @$articleSvc) ->
    console.log "ArticlePageCtrl", @$routeParams
    @$articleSvc.get @$routeParams.id, (article) =>
      @$scope.article = article
      @$scope.formatDate = @formatDate
      


angular.module("ArticlePageCtrl",[]).controller("ArticlePageCtrl", ["$scope", "$routeParams", "ArticleSvc", ArticlePageCtrl])