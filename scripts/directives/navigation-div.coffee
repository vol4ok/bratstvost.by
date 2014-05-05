module = angular.module("appLibs")

NavMenuDiv = ($location) ->
  restrict: "A"
  scope: {}
  controller: class

    updateActiveItem: =>
      maxMatch = 0;        
      newItem = null
      path = $location.path()
      for item in @items
        if path is item.url
          newItem = item
          break
      @currItem.deactiveate() if @currItem
      if newItem
        newItem.activate() 
        @currItem = newItem
        @$scope.currPath = newItem.url
      else
        @$scope.currPath = undefined

    constructor: (@$scope) ->
      @items = []
      @$scope.$on "$locationChangeSuccess", (ev, newLocation, prewLocation) =>
        @updateActiveItem() if $location.path() isnt @$scope.currPath


  link: (scope, element, attr, ctrl) ->
    ctrl.updateActiveItem() unless scope.currPath

module.directive "navmenu", ["$location", NavMenuDiv]
      

module.directive "navitem", () ->
  restrict: "A"
  transclude: yes
  template: "<a ng-href=\"{{url}}\" ng-transclude></a>"
  scope: 
    url: "=navitem"
  require: "^navmenu"
  link: (scope, element, attrs, menuCtrl) ->
    scope.activate = ->
      element.addClass("active")
    scope.deactiveate = ->
      element.removeClass("active")
    menuCtrl.items.push(scope)