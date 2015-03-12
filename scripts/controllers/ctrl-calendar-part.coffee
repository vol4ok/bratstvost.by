class CalendarPartCtrl

  constructor: (@$scope, @$http) ->
    @$http.get('/api/calendar')
    .success (data, status, headers, config) =>
      @$scope.calendarHtml = data.calendarHtml
    .error (data, status, headers, config) =>
      console.error(data)

angular.module("CalendarPartCtrl", []).controller("CalendarPartCtrl",  ["$scope", "$http", CalendarPartCtrl])