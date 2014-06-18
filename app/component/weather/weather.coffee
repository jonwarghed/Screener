define ["knockout","jquery"], (ko,$) ->
  class WeatherViewModel
    iconTable =
      '01d':'wi-day-sunny',
      '02d':'wi-day-cloudy',
      '03d':'wi-cloudy',
      '04d':'wi-cloudy-windy',
      '09d':'wi-showers',
      '10d':'wi-rain',
      '11d':'wi-thunderstorm',
      '13d':'wi-snow',
      '50d':'wi-fog',
      '01n':'wi-night-clear',
      '02n':'wi-night-cloudy',
      '03n':'wi-night-cloudy',
      '04n':'wi-night-cloudy',
      '09n':'wi-night-showers',
      '10n':'wi-night-rain',
      '11n':'wi-night-thunderstorm',
      '13n':'wi-night-snow',
      '50n':'wi-night-alt-cloudy-windy'

    weatherParams =
      'q':'Gothenburg,Sweden',
      'units':'metric'

    constructor:->
      @weatherData = ko.observable()
      @sunrise = ko.computed =>
        read : new Date(@weatherData().sys.sunrise*1000).toTimeString().substring 0,5 if @weatherData()?
        deferEvaluation: true
      @sunset = ko.computed =>
        read : new Date(@weatherData().sys.sunset*1000).toTimeString().substring 0,5 if @weatherData()?
        deferEvaluation: true
      @wind = ko.computed =>
        read : Math.round @weatherData().wind.speed if @weatherData()?
        deferEvaluation: true
      @temperature = ko.computed =>
        read : Math.round @weatherData().main.temp if @weatherData()?
        deferEvaluation: true
      @weatherIcon = ko.computed =>
        read : @iconTable[@weatherData().weather[0].icon] if @weatherData()?
        deferEvaluation: true
      @isSunrise = ko.computed =>
        read : @weatherData().sys.sunrise*1000 < new Date < @weatherData().sys.sunset*1000 if @weatherData()?
        deferEvaluation: true

      setInterval @updateCurrentWeather,60000

    updateCurrentWeather: =>
      $.getJSON 'http://api.openweathermap.org/data/2.5/weather', weatherParams, @weatherData