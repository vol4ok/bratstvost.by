class PastEventCtrl
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

  constructor: (@$scope, @$eventsSvc) ->
    @$eventsSvc.all().then (events) =>

      @$scope.formatPhone = formatPhone

      today = moment().startOf('day').toDate()
      @$scope.data = {}
      @$scope.data.pastEvents = []

      for ev in events
        if ev.phone
          ev.phone = @$scope.formatPhone(ev.phone)

        ev._date = moment(ev.date).toDate()
        ev.month = moment(ev.date).format("MMM")
        ev.day = moment(ev.date).format("D")
        ev.dayOfWeek = moment(ev.date).format("dd")

        if ev._date < today
          @$scope.data.pastEvents.push(ev)

      @$scope.data.pastEvents = @$scope.data.pastEvents.sort (a,b) -> b._date.valueOf() - a._date.valueOf()
      @$scope.data.pastEventsByMonth = {}
      @$scope.data.pastEventsByYear = {}

      for ev in @$scope.data.pastEvents
        @$scope.data.pastEventsByYear[2100 - moment(ev.date).year()] ?= 
          year: moment(ev.date).format("YYYY")
          pastEventsByMonth: {}
        @$scope.data.pastEventsByYear[2100 - moment(ev.date).year()].pastEventsByMonth[12 - moment(ev.date).month()] ?= 
          month: moment(ev.date).format("MMMM"), 
          events: []
        @$scope.data.pastEventsByYear[2100 - moment(ev.date).year()].pastEventsByMonth[12 - moment(ev.date).month()].events.push(ev)            

angular.module("PastEventCtrl", ["EventsSvc"]).controller("PastEventCtrl", ["$scope", "EventsSvc", PastEventCtrl])