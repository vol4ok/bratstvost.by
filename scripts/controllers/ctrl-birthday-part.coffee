class BirthdayPartCtrl
  
  constructor: (@$scope, @$core, @phoneHelpers) ->
    @$core.$members.all().then (members) =>
      @$scope.members = members
      @$scope.birthdayMembers = []
      @$scope.angeldayMembers = []
      @$scope.nearBirthdayMembers = []
      @$scope.nearAngeldayMembers = []

      todayInMD = moment([0, moment().month(), moment().date()]);
      monthRu = [' января',' февраля',' марта',' апреля',' мая',' июня',' июля',' августа',' сентября',' октября',' ноября',' декабря']

      for mem in members
        mem.phoneRaw = @phoneHelpers.formatPhoneRaw(mem.phone)
        mem.phoneNice = @phoneHelpers.formatPhoneNice(mem.phone)

        if mem.birthDate
          parsedDate = moment(mem.birthDate).toDate()
          memInMD = moment([0, parsedDate.getMonth(), parsedDate.getDate()])
          diffDays = memInMD.diff(todayInMD, 'days')

          if diffDays == 0
            @$scope.birthdayMembers.push(mem)
          else if diffDays in [1,2,364,365]
            mem.nearBirthdayRu = parsedDate.getDate() + monthRu[parsedDate.getMonth()]
            @$scope.nearBirthdayMembers.push(mem)

        if mem.angelDate
          parsedDate = moment(mem.angelDate).toDate()
          memInMD = moment([0, parsedDate.getMonth(), parsedDate.getDate()])
          diffDays = memInMD.diff(todayInMD, 'days')

          if diffDays == 0
            @$scope.angeldayMembers.push(mem)
          else if diffDays in [1,2,364,365]
            mem.nearAngeldayRu = parsedDate.getDate() + monthRu[parsedDate.getMonth()]
            @$scope.nearAngeldayMembers.push(mem)

angular.module("BirthdayPartCtrl", []).controller("BirthdayPartCtrl",  ["$scope", "$core", "phoneHelpers", BirthdayPartCtrl])