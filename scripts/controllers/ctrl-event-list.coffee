class EventListCtrl
  parse_phone = (phone) ->
    res = ""
    for c,i in phone
      res += c if c in "+0123456789".split("")
    return {
      nums: res.slice(-7)
      code: res.slice(-9,-7)
    }

  format_phone_nice = (p) ->
    p = parse_phone(p) if typeof p is "string"
    n = p.nums.split("")
    return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

  format_phone_raw = (p) ->
    p = parse_phone(p) if typeof p is "string"
    return "+375#{p.code}#{p.nums}"

  formatPhone = (p) ->
    p = parse_phone(p)
    return "<a href=\"phone:#{format_phone_raw(p)}\">#{format_phone_nice(p)}</a>"

  constructor: (@$scope, @$eventsSvc) ->
    @$eventsSvc.all().then (events) =>

      console.log events

      @$scope.formatPhone = formatPhone

      @$scope.data = {}
      @$scope.data.lastUpdate = moment(DATA.last_update).fromNow()
      

      for ev in events when ev.phone
        ev.phone = @$scope.formatPhone(ev.phone)

      for ev in events
        ev._date = moment(ev.date).toDate()
        ev.month = moment(ev.date).format("MMM")
        ev.day = moment(ev.date).format("D")
            
      @$scope.data.events = events
      @$scope.data.pastEvents = []
      @$scope.data.nextEvents = []

      today = moment().startOf('day').toDate()


      for ev in events
        if ev._date < today
          @$scope.data.pastEvents.push(ev)
        else
          @$scope.data.nextEvents.push(ev)

      @$scope.data.nextEvents = @$scope.data.nextEvents.sort (a,b) -> a._date.valueOf() - b._date.valueOf()
      @$scope.data.pastEvents = @$scope.data.pastEvents.sort (a,b) -> b._date.valueOf() - a._date.valueOf()

      @$scope.data.pastEventsByMonth = {}
      for ev in @$scope.data.pastEvents
        @$scope.data.pastEventsByMonth[12 - moment(ev.date).month()] ?= month: moment(ev.date).format("MMMM"), events: []
        @$scope.data.pastEventsByMonth[12 - moment(ev.date).month()].events.push(ev)    

angular.module("EventListCtrl", ["EventsSvc"]).controller("EventListCtrl", ["$scope", "EventsSvc", EventListCtrl])