module = angular.module("TabDivs", [])

module.directive "tabList", [ "$location", ($location) ->
  restrict: "A"
  scope:
    pageListName: "@tabList"
  link: 
    post: (scope, elem, attr, ctrl) ->
      ctrl.currentTab = ctrl.findActiveTab()
      hash = $location.hash()
      if hash and tab = ctrl.getTabByName(hash)
        ctrl.switchTab(tab)
      else if ctrl.currentTab
        ctrl.switchTab(ctrl.currentTab)

  controller: class

    switchTab: (tab, emit = true) =>
      return unless tab
      @currentTab?.deactiveate()
      @currentTab = tab
      @currentTab.activate()
      if emit
        @pageListScope?.$emit("select-page", @currentTab.name)

    on_tabClick: (ev, tab) =>
      @switchTab(tab)

    on_hello: (ev, pageListScope) =>
      if pageListScope.name is @$scope.pageListName
        @pageListScope = pageListScope
        @pageListScope?.$emit("select-page", @currentTab.name)

    getTabByName: (name) ->
      for tab in @tabs
        return tab if tab.name is name

    findActiveTab: ->
      for tab in @tabs
        return tab if tab.isActive()
      

    constructor: (@$scope) ->
      @tabs = []
      @pageListScope = null
      @$scope.$on('tab-click', @on_tabClick)
      @$scope.$on('hello-tab-list', @on_hello)
]


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
    scope.isActive = -> 
      element.hasClass("active")
    ctrl.tabs.push(scope)
    element.click ->
      scope.$parent.$broadcast("tab-click", scope)
]


module.directive "pageList", ["$timeout", "$location", ($timeout, $location) ->
  restrict: "A"
  scope: 
    name: "@pageList"
    index: "@"
  controller: class

    switchPage: (pageName) ->
      return unless pageName and @pages[pageName]
      @currentPage?.deactiveate()
      @currentPage = @pages[pageName]
      @currentPage.activate()
      $timeout ->
        $location.hash(pageName)
          


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