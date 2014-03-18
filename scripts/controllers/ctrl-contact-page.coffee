class ContactPageCtrl

  constructor: (@$scope) ->
    $("a.img").fluidbox({viewportFill: .5})

angular.module("ContactPageCtrl",[]).controller("ContactPageCtrl", ["$scope", ContactPageCtrl])