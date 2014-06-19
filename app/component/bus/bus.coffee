define ["knockout","jquery"], (ko,$) ->
  class BusViewModel
    constructor: ->
      @bus = ko.observableArray()
      @updateBusSchedule()
      setInterval @updateBusSchedule, 100000

    tripQuestion = 'https://api.vasttrafik.se/bin/rest.exe/v1/departureBoard?id=.kvil&format=json&jsonpCallback=?&direction=.anekd&authKey=5914945f-3e58-4bbc-8169-29571809775d&needJourneyDetail=0&timeSpan=1439&maxDeparturesPerLine=4';
    updateBusSchedule: =>
      $.getJSON tripQuestion, (data) =>
        @bus data.DepartureBoard.Departure

