class NoticeEditorCtrl

  _save: (notice) =>
    @$scope.data.isNew = yes unless notice._id
    notice._id ?= uuid.v4()
    notice.updated ?= moment().toISOString()
    notice.created ?= moment().toISOString()
    notice.type ?= "notice"
    console.log "_save", notice
    if @$scope.data.isNew
      @$noticeSvc.create(notice).then (resp) =>
        console.log resp
      @$scope.data.isNew = no
    else
      @$noticeSvc.save(notice._id, notice).then (resp) =>
        console.log resp
    @$scope.data.notices[notice._id] = notice;
    @_updateNoticeArray()


  select: (notice) =>
    @$scope.data.isNew = no
    @$scope.data.current = notice

  create: =>
    @$scope.data.isNew = yes
    @$scope.data.current = 
      _id: uuid.v4()
      type: "notice"
      body: ""
      show_begins: moment().toISOString()
      show_ends: "9999-12-31T23:59:59.999Z"
      priority: 0
      style: ""
      published: yes
      created: moment().toISOString()
      updated: moment().toISOString()


  deleteCurrent: =>
    if confirm("Точно удалить?")
      @$noticeSvc.delete(@$scope.data.current._id).then (resp) =>
        console.log resp
      delete @$scope.data.notices[@$scope.data.current._id]
      @_updateNoticeArray()
      @$scope.data.current = @$scope.data.noticesArr[0]

  saveCurrent: =>
    if angular.isArray(@$scope.data.current)
      last = null
      @$scope.data.isNew = yes
      for notice in @$scope.data.current
        @_save(notice)
        last = notice
      @$scope.data.current = last
    else
      @_save(@$scope.data.current)


  _updateNoticeArray: =>
    result = []
    for k,v of @$scope.data.notices
      result.push(v)
    result.sort (a,b) -> a.priority - b.priority
    @$scope.data.noticesArr = result


  constructor: (@$scope, @$noticeSvc, @$http) ->
    @$scope.data = {}

    @$scope.select = @select
    @$scope.create = @create
    @$scope.saveCurrent = @saveCurrent
    @$scope.deleteCurrent = @deleteCurrent

    @$noticeSvc.all().then (notices) => 
      console.log notices
      @$scope.data.notices = {}
      for notice in notices
        notice.isShowed = yes
        if notice.show_ends and moment().isAfter(notice.show_ends)
          notice.isShowed = no
        @$scope.data.notices[notice._id] = notice
      @_updateNoticeArray()

    @$scope.$watch "data.current._id", (value) =>
      console.log 'NOTICE: $watch "data.current._id"'
      return if angular.isArray(@$scope.data.current)
      @$scope.data.currentJSON = JSON.stringify(@$scope.data.current, null, "  ")

    @$scope.$watch "data.currentJSON", =>
      return unless @$scope.data.currentJSON
      console.log 'NOTICE: $watch "data.currentJSON"'
      try
        @$scope.data.current = JSON.parse(@$scope.data.currentJSON)
      catch e
        @$scope.data.jsonErrorMessage = e.message
        console.log ">> jsonErrorMessage", @$scope.data.jsonErrorMessage

angular.module("NoticeEditorCtrl", ["NoticeSvc"])
  .controller("NoticeEditorCtrl", ["$scope", "NoticeSvc", "$http", NoticeEditorCtrl])
