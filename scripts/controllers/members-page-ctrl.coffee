MembersPageCtrl = ($scope, $core, phoneHelpers) ->
  MembersPageCtrl.$inject = ["$scope", "$core", "phoneHelpers"]

  $scope.members = []
  $core.$members.all().then (members) ->
    $scope.members = members

angular.module("appLibs").controller("MembersPageCtrl", MembersPageCtrl)