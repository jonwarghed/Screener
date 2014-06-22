define ["knockout"], (ko) ->
  class bustimetableViewModel
    constructor: ->
      @lines = ko.observableArray()
