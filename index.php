<html>
<head>
<title>Magic Mirror</title>
<link rel="stylesheet" href="css/main.css" type="text/css" />
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/knockout/knockout-3.0.0.js"></script>
<script src="js/moment.min.js"></script>
</head>
<body>


	<div class="top left"><div class="small dimmed" data-bind="text: date"></div><div data-bind="html: times"></div><div class="calendar xxsmall"></div></div>
	<div class="top right"><div class="windsun small dimmed"></div><div class="temp"></div><div class="forecast small dimmed"></div></div>

	<div class="bottom left small light">
	<p id="0">.</p>
	<p id="1">.</p>
	<p id="2">.</p>
	<p id="3">.</p>
	</div>


<script>
$(document).ready(function () {

    /*	For trip call (from/to)
    	var tripQuestion = 'https://api.vasttrafik.se/bin/rest.exe/v1/trip?originId=.kvil&destId=.anekd&format=json&jsonpCallback=tripSearch&authKey=5914945f-3e58-4bbc-8169-29571809775d&needJourneyDetail=0';
    */
    var tripQuestion = 'https://api.vasttrafik.se/bin/rest.exe/v1/departureBoard?id=.kvil&format=json&jsonpCallback=?&direction=.anekd&authKey=5914945f-3e58-4bbc-8169-29571809775d&needJourneyDetail=0&timeSpan=121';
    $.getJSON( tripQuestion,function(result) {
        var bus =[];
        var time=[];
		
        $.each(result.DepartureBoard.Departure, function(i, data) {
            bus.push(data.name);
            time.push(data.rtTime);

            //Now Add Bus and Times to page and/or time left
            var textField = "#" + i.toString();
            $(textField).text(bus[i] + " " + time[i]);
        });
    });

});
function AppViewModel() {
    self = this;
	
	this.times  = ko.observable("");
	this.date = ko.observable("");
	
	this.updateClock = function(){
	
	var now = moment();
	var dates = now.format('LLLL').split(' ',4);
	
	self.date(dates[0] + ' ' + dates[1] + ' ' + dates[2] + ' ' + dates[3]);
	
	var times = now.format('HH') + ':' + now.format('mm') + '<span class="sec">'+now.format('ss')+'</span>';
	self.times(times);
	
	};

	setInterval(this.updateClock,1000);
	
}
ko.applyBindings(new AppViewModel());
</script>



</body>
</html>

