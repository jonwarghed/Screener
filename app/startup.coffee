requirejs.config
  baseUrl : ""
  paths :
    "text" : "app/lib/text"
    "knockout" : "app/lib/knockout"
    "jquery" : "app/lib/jquery"
    "moment" : "app/lib/moment"

define ["jquery","knockout"], ($, ko) ->
  #Defines common URL conventions used by components in this site
  registerComponent = (name) ->
    ko.components.register name,
      template:
        require: "text!app/component/" + name + "/" + name + ".html",
      viewModel:
        require : "app/component/" + name + "/" + name

  registerComponentWithDatabind = (name) ->
    ko.components.register name,
      require: "app/component/" + name + "/" + name

  registerComponentWithDatabind "bus"
  registerComponent "clock"
  registerComponent "weather"
  registerComponent "bustimetable"

  #Start the application
  ko.applyBindings()