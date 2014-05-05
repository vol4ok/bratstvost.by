angular.module("appLibs").directive "member", ["phoneHelpers", (phoneHelpers) ->
  restrict: "E"
  replace: yes
  scope: {
    model: "="
  }
  templateUrl: "member-view-template"
  link: (scope, element, attrs) ->
    console.log "render", scope.model
    scope.$watch "model", () ->
      return unless scope.model
      scope.model.phoneLink = phoneHelpers.formatPhoneLink(scope.model.phone)
      scope.model.emailLink = "<a href=\"mailto:#{scope.model.email}\">#{scope.model.email}</a>"
      console.log scope.model
]