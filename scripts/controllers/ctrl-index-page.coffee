class IndexPageCtrl

  constructor: (@$scope) ->
    $('#main-carousel').carousel(interval: 4000, pause: "false")

angular.module("IndexPageCtrl",[]).controller("IndexPageCtrl", ["$scope", IndexPageCtrl])