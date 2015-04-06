class MainCtrl
  parse_phone = (phone) ->
    res = ""
    for c in phone
      res += c if c in "+0123456789".split("")
    return {
      nums: res.slice(-7)
      code: res.slice(-9,-7)
    }

  format_phone_nice = (p) ->
    n = p.nums.split("")
    return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

  formatPhone = (p) ->
    p = parse_phone(p)
    return "<a href=\"phone:+375#{p.code}#{p.nums}\">#{format_phone_nice(p)}</a>"

  constructor: (@$scope, @$mainSvc) ->
    @$mainSvc.all().then (data) =>

      @$scope.calendarHtml = data.calendarHtml
      @$scope.innerTemplateUrl = ''
      @$scope.notices = data.notices
      @$scope.anews = data.news

      for news in @$scope.anews
        news.timeAgo = moment(news.date).fromNow()
      # events
      @$scope.formatPhone = formatPhone

      _last_update = moment(data.events[0].updated)
      @$scope.nextEvents = []
      lastVisit = moment(localStorage.getItem("lastVisit"))

      for ev in data.events
        updated = moment(ev.updated)
        if updated.toDate() > _last_update.toDate()
          _last_update = updated
        if ev.phone
          ev.phone = @$scope.formatPhone(ev.phone)
        ev._date = moment(ev.date).toDate()
        ev.month = moment(ev.date).format("MMM")
        ev.day = moment(ev.date).format("D")
        ev.dayOfWeek = moment(ev.date).format("dd")
        if (lastVisit)
          ev.isNew = moment(ev.updated).isAfter(lastVisit)
        else
          ev.isNew = true
        @$scope.nextEvents.push(ev)

      @$scope.lastUpdate = _last_update.fromNow()
      @$scope.nextEvents = @$scope.nextEvents.sort (a,b) -> a._date.valueOf() - b._date.valueOf()
      localStorage.setItem("lastVisit", moment().toISOString())

angular.module("MainCtrl",["MainSvc"]).controller("MainCtrl", ["$scope", "MainSvc", MainCtrl])