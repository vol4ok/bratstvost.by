class IndexPageCtrl

  constructor: (@$scope) ->
    $('#main-carousel').carousel(interval: 4000)

angular.module("IndexPageCtrl",[]).controller("IndexPageCtrl", ["$scope", IndexPageCtrl])