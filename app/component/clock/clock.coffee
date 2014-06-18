define ["knockout","moment"], (ko,moment) ->
  class ClockViewModel
    constructor: ->
      @now = ko.observable(moment())
      @hour = ko.computed =>
        @now().format('HH:mm:ss')
      @date = ko.computed =>
        @now().format('LLLL')

      updateClock: =>
        @now moment()

    setInterval @updateClock, 999