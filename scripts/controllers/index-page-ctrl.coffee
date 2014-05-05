IndexPageCtrl = ($scope, $core, phoneHelpers) ->
  IndexPageCtrl.$inject = ["$scope", "$core", "phoneHelpers"]

  console.log 'IndexPageCtrl', $scope, phoneHelpers
  {$events, $news, $notices} = $core
  $('#main-carousel').carousel(interval: 4000, pause: "false")

  $scope.isNew = (event) ->
  $scope.events = null

  $events.loadEventList().then (eventList) ->
    $scope.events = eventList.getUpcomingEvents()

    lastEvent = _.max($scope.events, 'updated')
    $scope.lastUpdate = moment(lastEvent.updated).fromNow()

    $scope.pastEvents = eventList.getPastEvents()
    $scope.pastEventsByYear = {}
    for ev in $scope.pastEvents
      $scope
        .pastEventsByYear[2100 - ev.date.getFullYear()] ?= 
          year: moment(ev.date).format("YYYY")
          pastEventsByMonth: {}
      $scope
        .pastEventsByYear[2100 - ev.date.getFullYear()]
        .pastEventsByMonth[12 - ev.date.getMonth()] ?=
          month: moment(ev.date).format("MMMM")
          events: []
      $scope
        .pastEventsByYear[2100 - ev.date.getFullYear()]
        .pastEventsByMonth[12 - ev.date.getMonth()]
        .events.push(ev)            

    window._test = $scope

  



angular.module("appLibs").controller("IndexPage2Ctrl", IndexPageCtrl)