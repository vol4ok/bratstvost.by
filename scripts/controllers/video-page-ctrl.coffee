VideoPageCtrl = ($scope, $core) ->
  VideoPageCtrl.$inject = ["$scope", "$core"]

  $core.$videos.all().then (videos) =>
    videos.sort (a,b) -> moment(b.publish_date).valueOf() - moment(a.publish_date).valueOf()

    $scope.videos = videos
    $scope.videosLeft = []
    $scope.videosRight = []

    for video,i in videos
      if i & 1
        $scope.videosRight.push(video)
      else
        $scope.videosLeft.push(video)
    

angular.module("appLibs").controller("VideoPageCtrl", VideoPageCtrl)