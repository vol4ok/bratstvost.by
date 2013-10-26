class NoticeListCtrl

  constructor: (@$scope, @$noticeSvc) ->
    @$noticeSvc.all().then (notices) =>
      @$scope.data = {}
      @$scope.data.notices = []

      currentDate = moment()
      for notice in notices when currentDate.isBefore(notice.show_ends)
        @$scope.data.notices.push(notice)

      @$scope.data.notices.sort (a,b) -> b.priority - a.priority

angular.module("NoticeListCtrl",["NoticeSvc"]).controller("NoticeListCtrl", ["$scope", "NoticeSvc", NoticeListCtrl])