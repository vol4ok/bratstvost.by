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
      scope.model.phoneRaw = phoneHelpers.formatPhoneRaw(scope.model.phone) 
      scope.model.phoneNice = phoneHelpers.formatPhoneNice(scope.model.phone)
      console.log scope.model
]