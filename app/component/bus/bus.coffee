define ["knockout","jquery","text!./bus.html"], (ko,$,templateMarkup) ->
  class BusViewModel
    constructor: (params) ->
      @bus = ko.observableArray()
      @name = ko.observable(params.name)
      @tripQuestion = ""
      @setParameters(params)
      @updateBusSchedule()
      setInterval @updateBusSchedule, 30000

    setParameters: (params )=>
      id = "&id=" + params.start
      baseurl = 'https://api.vasttrafik.se/bin/rest.exe/v1/departureBoard'
      direction = "&direction=" + params.direction
      timeSpan = "&timeSpan=" + if params.timeSpan? then params.timeSpan else 60
      maxDeparturesPerLine= "&maxDeparturesPerLine=" + if params.departures? then params.departures else 1
      authkey = "&authKey=5914945f-3e58-4bbc-8169-29571809775d"
      standard = "?format=json&jsonpCallback=?&needJourneyDetail=0"
      @tripQuestion = baseurl + standard + authkey + id + direction + timeSpan + maxDeparturesPerLine

    updateBusSchedule: =>
      $.getJSON @tripQuestion, (data) =>
        @bus data.DepartureBoard.Departure

  viewModel:  BusViewModel
  template: templateMarkup
