class Event
  constructor: (data) ->
    _.assign(this, data)
    @date = new Date(@date)
    @updated = new Date(@updated)
    @created = new Date(@created)


class EventList
  constructor: (data) ->
    @events = data.map (eventData) -> new Event(eventData)

  getUpcomingEvents: ->
    today = moment().startOf('day').toDate()
    return _.select @events, (ev) -> ev.date >= today

  getPastEvents: ->
    today = moment().startOf('day').toDate()
    return _.select @events, (ev) -> ev.date < today


$coreEvents = ($q, $http) ->
  $coreEvents.$inject = ["$q", "$http"]

  eventList = null

  loadEventList = () ->
    deffered = $q.defer()

    $http.get('/api/events')
      .success (data, status, headers, config) => 
        eventList = new EventList(data)
        deffered.resolve(eventList)
      .error (data, status, headers, config) => 
        deffered.reject()

    return deffered.promise

  getEventList = -> eventList

  return {
    loadEventList
    getEventList
  }


angular.module('coreLibs').factory "$coreEvents", $coreEvents