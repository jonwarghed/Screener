define ["knockout","jquery"], (ko,$) ->
  class WeatherViewModel
    weatherParams =
      'q':'Gothenburg,Sweden',
      'units':'metric'


    constructor:->
      @iconTable =
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


      @weatherData = ko.observable(null)
      @sunrise = ko.computed =>
        new Date(@weatherData().sys.sunrise*1000).toTimeString().substring(0,5) if @weatherData()?
      @sunset = ko.computed =>
        new Date(@weatherData().sys.sunset*1000).toTimeString().substring 0,5 if @weatherData()?
      @wind = ko.computed =>
        Math.round @weatherData().wind.speed if @weatherData()?
      @temperature = ko.computed =>
        Math.round @weatherData().main.temp if @weatherData()?
      @weatherIcon = ko.computed =>
        @iconTable[@weatherData().weather[0].icon] if @weatherData()?
      @isSunrise = ko.computed =>
        @weatherData().sys.sunrise*1000 < new Date < @weatherData().sys.sunset*1000 if @weatherData()?

      setInterval @updateCurrentWeather,5000

    updateCurrentWeather: =>
      $.getJSON 'http://api.openweathermap.org/data/2.5/weather', weatherParams, @weatherData