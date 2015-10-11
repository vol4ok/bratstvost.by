class ThanksPageCtrl

  constructor: (@$scope) ->
    $("a.img").fluidbox()

angular.module("ThanksPageCtrl",[]).controller("ThanksPageCtrl", ["$scope", ThanksPageCtrl])