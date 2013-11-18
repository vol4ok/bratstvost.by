angular.module("ArchiveCollapsDiv", []).directive "archiveitem", () ->
  restrict: "E"
  transclude: yes
  replace: yes
  scope: {
    title: "="
  }
  templateUrl: "archive-collapse-template"
  link: (scope, element, attrs) ->