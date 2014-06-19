define ["knockout","moment"], (ko,moment) ->
  class ClockViewModel
    constructor: ->
      @now = ko.observable(moment())
      @hour = ko.computed =>
        @now().format('HH:mm:ss')
      @date = ko.computed =>
        @now().format('dddd MMMM DD YYYY')
      setInterval @updateClock, 999

    updateClock: =>
      @now moment()

