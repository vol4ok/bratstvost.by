angular.module("appLibs").directive "eventview2", ["phoneHelpers", (phoneHelpers) ->
  restrict: "E"
  replace: yes
  scope: {
    event: "="
    # expanded: "="
    # highlighted: "="
    # default: "="
  }
  templateUrl: "eventview-template"
  link: (scope, element, attrs) ->
    scope.expanded ?= false
    scope.highlighted ?= false
    scope.color ?= "default"
    scope.$watch "event", () ->
      return unless scope.event || scope.event.date
      mdate = moment(scope.event.date)
      scope.event._date = mdate.toDate()
      scope.event.month = mdate.format("MMM")
      scope.event.day   = mdate.format("D")
      scope.event.dayOfWeek = mdate.format("dd")
      scope.event.isNew = false
      #scope.event.phone = phoneHelpers.formatPhone(scope.event.phone)
]