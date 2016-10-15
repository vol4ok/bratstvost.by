MembersPageCtrl = ($scope, $core) ->
  MembersPageCtrl.$inject = ["$scope", "$core"]

  $scope.members = []
  $scope.rmembers = []
  $core.$members.all().then (members) ->
    for mem in members
      if mem.reserved
        $scope.rmembers.push(mem)
      else
        $scope.members.push(mem)

angular.module("appLibs").controller("MembersPageCtrl", MembersPageCtrl)