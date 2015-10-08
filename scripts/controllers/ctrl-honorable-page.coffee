class HonorablePageCtrl

  constructor: (@$scope) ->
    $("a.img").fluidbox({viewportFill: .5})

angular.module("HonorablePageCtrl",[]).controller("HonorablePageCtrl", ["$scope", HonorablePageCtrl])