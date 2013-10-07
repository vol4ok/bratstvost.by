class AdsListCtrl

  constructor: (@$scope) ->
    data = angular.copy(DATA)

    @$scope.data = {}
    @$scope.data.ads = DATA.ads

    @$scope.data.ads = []
    for ad in data.ads when moment().isBefore(ad.show_to)
      @$scope.data.ads.push(ad)

    @$scope.data.ads.sort (a,b) -> b.priority - a.priority

angular.module("AdsListCtrl",[]).controller("AdsListCtrl", ["$scope", AdsListCtrl])