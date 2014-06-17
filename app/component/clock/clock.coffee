class ClockViewModel
  constructor: ->
    @now = ko.observable()
    @hour = ko.computed =>
      @now.format('HH:mm:ss')
    @date = ko.computed =>
      @now.format('L L L L')

    updateClock: =>
      @now moment()

  setInterval @updateClock, 999

$ ->
  ko.applyBindings new ClockViewModel
