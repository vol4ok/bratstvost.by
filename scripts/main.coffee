window.app = angular.module("bratstvost-app", [])

class EventListCtrl
  $scope = {}

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

  $scope.formatPhone = (p) ->
    p = parse_phone(p)
    console.log "<a href=\"phone:#{format_phone_raw(p)}\">#{format_phone_nice(p)}</a>"
    return "<a href=\"phone:#{format_phone_raw(p)}\">#{format_phone_nice(p)}</a>"

  constructor: (scope) ->    
    $scope = scope extends $scope
    json = $('#events-data').text()
    $scope.events = JSON.parse(json)
    for ev in $scope.events when ev.phone
      ev.phone = $scope.formatPhone(ev.phone)

app.controller "EventListCtrl", ["$scope", EventListCtrl]

