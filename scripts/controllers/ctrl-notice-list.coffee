class NoticeListCtrl

  constructor: (@$scope, @$noticeSvc) ->
    @$noticeSvc.all().then (notices) =>
      @$scope.notices = notices
      @$scope.notices.sort (a,b) -> b.priority - a.priority

angular.module("NoticeListCtrl",["NoticeSvc"]).controller("NoticeListCtrl", ["$scope", "NoticeSvc", NoticeListCtrl])