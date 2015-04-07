MembersPageCtrl = ($scope, $core) ->
  MembersPageCtrl.$inject = ["$scope", "$core"]

  $scope.members = []
  $core.$members.all().then (members) ->
    $scope.members = members

angular.module("appLibs").controller("MembersPageCtrl", MembersPageCtrl)