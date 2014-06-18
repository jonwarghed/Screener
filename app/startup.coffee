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
        require: "app/component/" + name + "/" + name

  registerComponent "bus"
  registerComponent "clock"
  registerComponent "weather"

  #Start the application
  ko.applyBindings()