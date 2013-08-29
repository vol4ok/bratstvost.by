class EventFormCtrl
  $scope = {}

  moment.lang("ru")

  $scope.form = {}
  $scope.event = {}

  parse_phone = (phone) ->
    return "" unless phone
    res = ""
    for c,i in phone
      res += c if c in "+0123456789".split("")
    return {
      nums: res.slice(-7)
      code: res.slice(-9,-7)
    }

  format_phone_nice = (p) ->
    p = parse_phone(p) if typeof p is "string"
    return "" unless p.code or p.nums
    n = p.nums.split("")
    return "" if n.length < 7
    return "8 (0#{p.code}) #{n[0]}#{n[1]}#{n[2]}-#{n[3]}#{n[4]}-#{n[5]}#{n[6]}"

  format_phone_raw = (p) ->
    p = parse_phone(p) if typeof p is "string"
    return "" unless p.code or p.nums
    return "+375#{p.code}#{p.nums}"

  $scope.formatPhone = (p) ->
    return "" unless p
    p = parse_phone(p)
    return "" unless p.code or p.nums
    return "<a href=\"phone:#{format_phone_raw(p)}\">#{format_phone_nice(p)}</a>"


  create_abbr_for_words = (str) ->
    return "" unless str
    str.replace(/ПНИ/g, '<abbr title="Психоневрологический интернат">ПНИ</abbr>')

  constructor: (scope) -> 

    $scope = scope extends $scope

    $scope.$watch "form.date", ->
      if $scope.form.date
        d = moment($scope.form.date, ["DD MMM", "DD-MM", "DD.MM"], "ru")
        $scope.event.day   = d.format("D")
        $scope.event.month = d.format("MMM")

    $scope.$watch "form.title", ->
      $scope.event.title = create_abbr_for_words($scope.form.title)

    $scope.$watch "form.body", ->
      $scope.event.body = create_abbr_for_words($scope.form.body)

    $scope.$watch "form.meeting_place", ->
      $scope.event.meeting_place = $scope.form.meeting_place

    $scope.$watch "form.meeting_time", ->
      $scope.event.meeting_time = $scope.form.meeting_time

    $scope.$watch "form.event_place", ->
      $scope.event.event_place = $scope.form.event_place

    $scope.$watch "form.event_time", ->
      $scope.event.event_time = $scope.form.event_time

    $scope.$watch "form.organizer", ->
      $scope.event.organizer = $scope.form.organizer

    $scope.$watch "form.phone", ->
      $scope.event.phone = $scope.formatPhone($scope.form.phone)

app.controller("EventFormCtrl", ["$scope", EventFormCtrl])

