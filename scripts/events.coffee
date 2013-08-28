class EventFormCtrl
  $scope = {}

  moment.lang("ru")

  $scope.form = 
    title: ""
    _day: "?"
    _month: "---"

  create_abbr_for_words = (str) ->
    return "" unless str
    str.replace(/ПНИ/g, '<abbr title="Психоневрологический интернат">ПНИ</abbr>')

  constructor: (scope) -> 

    $scope = scope extends $scope

    $scope.$watch "form._date", ->
      if $scope.form._date
        d = moment($scope.form._date, ["DD MMM", "DD-MM", "DD.MM"], "ru")
        $scope.form._day   = d.format("D")
        $scope.form._month = d.format("MMM")

    $scope.$watch "form._title", ->
      $scope.form.title = create_abbr_for_words($scope.form._title)

app.controller("EventFormCtrl", ["$scope", EventFormCtrl])

