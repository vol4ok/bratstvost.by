module = angular.module("TabDivs", [])

module.directive "tabList", () ->
  restrict: "A"
  scope:
    pageListName: "@tabList"
  controller: class

    switchTab: (tab) ->
      return unless tab
      @currentTab?.deactiveate()
      @currentTab = tab
      @currentTab.activate()
      @pageListScope?.$emit("select-page", @currentTab.name)

    on_tabClick: (ev, tab) =>
      @switchTab(tab)

    on_hello: (ev, pageListScope) =>
      if pageListScope.name is @$scope.pageListName
        @pageListScope = pageListScope
        @pageListScope?.$emit("select-page", @currentTab.name)

    constructor: (@$scope) ->
      @tabs = []
      @pageListScope = null
      @$scope.$on('tab-click', @on_tabClick)
      @$scope.$on('hello-tab-list', @on_hello)




module.directive "tab", [ "$timeout", ($timeout) ->
  restrict: "A"
  scope: 
    name: "@tab"
  require: "^tabList"
  link: (scope, element, attrs, ctrl) ->
    scope.activate = ->
      element.addClass("active")
    scope.deactiveate = ->
      element.removeClass("active")
    ctrl.tabs.push(scope)
    element.click ->
      scope.$parent.$broadcast("tab-click", scope)
    if element.hasClass("active")
      $timeout -> 
        ctrl.switchTab(scope) 
]


module.directive "pageList", ["$timeout", ($timeout) ->
  restrict: "A"
  scope: 
    name: "@pageList"
  controller: class

    switchPage: (pageName) ->
      return unless pageName and @pages[pageName]
      @currentPage?.deactiveate()
      @currentPage = @pages[pageName]
      @currentPage.activate()


    on_selectPage: (ev, pageName) =>
      @switchPage(pageName)

    constructor: (@$scope) ->
      @pages = {}
      @$scope.$on('select-page', @on_selectPage)
      $timeout =>
        @$scope.$root.$broadcast("hello-tab-list", @$scope)
]

module.directive "page", () ->
  restrict: "A"
  scope:
    name: "@page"
  require: "^pageList"
  link: (scope, element, attrs, ctrl) ->
    @currentPage = scope if element.hasClass("active")
    scope.activate = ->
      element.addClass("active")
    scope.deactiveate = ->
      element.removeClass("active")
    ctrl.pages[scope.name] = scope







# TabDiv = ($location) ->
#   restrict: "A"
#   scope: {}
#   controller: class

#     updateActiveItem: =>
#       maxMatch = 0;        
#       newItem = null
#       path = $location.path()
#       for item in @items
#         if path is item.url
#           newItem = item
#           break
#       @currItem.deactiveate() if @currItem
#       if newItem
#         newItem.activate() 
#         @currItem = newItem
#         @$scope.currPath = newItem.url
#       else
#         @$scope.currPath = undefined

#     constructor: (@$scope) ->
#       @items = []
#       @$scope.$on "$locationChangeSuccess", (ev, newLocation, prewLocation) =>
#         @updateActiveItem() if $location.path() isnt @$scope.currPath


#   link: (scope, element, attr, ctrl) ->
#     ctrl.updateActiveItem() unless scope.currPath

# module.directive "navmenu", ["$location", NavMenuDiv]

# module.directive "navitem", () ->
#   restrict: "A"
#   transclude: yes
#   template: "<a ng-href=\"{{url}}\" ng-transclude></a>"
#   scope: 
#     url: "=navitem"
#   require: "^navmenu"
#   link: (scope, element, attrs, menuCtrl) ->
#     scope.activate = ->
#       element.addClass("active")
#     scope.deactiveate = ->
#       element.removeClass("active")
#     menuCtrl.items.push(scope)