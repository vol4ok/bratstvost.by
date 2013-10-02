angular.module("ArchiveCollapsDiv", []).directive "archiveitem", () ->
  restrict: "E"
  transclude: yes
  replace: yes
  scope: {
    title: "="
  }
  templateUrl: "archive-collapse-template"
  link: (scope, element, attrs) ->
    # console.log "archive-collapse", scope, arguments
    # scope.expended ?= false
