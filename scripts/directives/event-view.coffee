app.directive "eventview", () ->
  restrict: "E"
  replace: yes
  scope: {
    event: "="
  }
  templateUrl: "eventview-template"
  link: (scope, element, attrs) ->
