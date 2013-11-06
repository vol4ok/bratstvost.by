class NewsEditorCtrl

  _save: (news) =>
    @$scope.data.isNew = yes unless news._id
    news._id ?= uuid.v4()
    news.updated ?= moment().toISOString()
    news.created ?= moment().toISOString()
    news.type ?= "news"
    console.log "_save", news
    if @$scope.data.isNew
      @$newsSvc.create(news).then (resp) =>
        console.log resp
      @$scope.data.isNew = no
    else
      @$newsSvc.save(news._id, news).then (resp) =>
        console.log resp
    @$scope.data.newsList[news._id] = news;
    @_updateNewsArray()


  select: (news) =>
    @$scope.data.isNew = no
    @$scope.data.current = news

  create: =>
    @$scope.data.isNew = yes
    @$scope.data.current = 
      _id: uuid.v4()
      type: "news"
      date: moment().toISOString()
      body: ""
      published: yes
      created: moment().toISOString()
      updated: moment().toISOString()


  deleteCurrent: =>
    if confirm("Точно удалить?")
      @$newsSvc.delete(@$scope.data.current._id).then (resp) =>
        # console.log resp
      delete @$scope.data.newsList[@$scope.data.current._id]
      @_updateNewsArray()
      @$scope.data.current = @$scope.data.newsArr[0]

  saveCurrent: =>
    if angular.isArray(@$scope.data.current)
      last = null
      @$scope.data.isNew = yes
      for news in @$scope.data.current
        @_save(news)
        last = news
      @$scope.data.current = last
    else
      @_save(@$scope.data.current)


  _updateNewsArray: =>
    result = []
    for k,v of @$scope.data.newsList
      result.push(v)
    result.sort (a,b) -> moment(b.date).valueOf() - moment(a.date).valueOf()
    @$scope.data.newsArr = result


  constructor: (@$scope, @$newsSvc, @$http) ->
    @$scope.data = {}

    @$scope.select = @select
    @$scope.create = @create
    @$scope.saveCurrent = @saveCurrent
    @$scope.deleteCurrent = @deleteCurrent

    @$newsSvc.all().then (newsList) => 
      currentDate = moment() 
      @$scope.data.newsList = {}
      for news in newsList
        @$scope.data.newsList[news._id] = news
      @_updateNewsArray()

    @$scope.$watch "data.current._id", (value) =>
      # console.log 'news: $watch "data.current._id"'
      return if angular.isArray(@$scope.data.current)
      @$scope.data.currentJSON = JSON.stringify(@$scope.data.current, null, "  ")

    @$scope.$watch "data.currentJSON", =>
      return unless @$scope.data.currentJSON
      # console.log 'news: $watch "data.currentJSON"'
      try
        @$scope.data.current = JSON.parse(@$scope.data.currentJSON)
      catch e
        @$scope.data.jsonErrorMessage = e.message
        # console.log ">> jsonErrorMessage", @$scope.data.jsonErrorMessage

angular.module("NewsEditorCtrl", ["NewsSvc"])
  .controller("NewsEditorCtrl", ["$scope", "NewsSvc", "$http", NewsEditorCtrl])
