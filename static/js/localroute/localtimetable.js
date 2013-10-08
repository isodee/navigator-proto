function localTimetableInit(date) {
	transSet=new reach.trans.TransSet();
	transSet.importData(transData);
	transSet.prepareDay(gis.util.Date.fromYMD(2013,10,5));
}

function getStopById(id) {
	var stopList = transSet.stopSet.list;

	for (var i in stopList)
		if (id == stopList[i].origId)
			return stopList[i];

	return undefined;
}

function getStopTimetables(stop) {
	var timetables = [];

	for (var i in stop.lineList) {
		var line = stop.lineList[i];
		var timeListIndex = stop.posList[i];
		var times = [];

		for (var j in line.tripList) {
			var trip = line.tripList[j];
			var time = trip.startTime + trip.timeList[timeListIndex];
			times.push(time);
		}

		var o = { 'k': line.tripList[0].key, 'v' : times };
		timetables.push(o);
	}

	return timetables;
}

function parseTimestamp(ts) {
	return [ ~~(ts / 3600), ~~(ts / 60) % 60 ];
}

function timestampToString(ts) {
	return parseTimestamp(ts).map(function(x) { return gis.Q.zeroPad(x, 2) }).join(":");
}

function getArrivalsByTrip(stop) {
	var map = {};
	var codeAndSuffix;

	stop.getArrivals().map(function(a) {
		var codeAndSuffix = reach.trans.Key.parseCode(a.trip.key.shortCode);
		var id = codeAndSuffix['id'];

		if (!map[id])
			map[id] = [];

		map[id].push({ time: timestampToString(a.time), suffix: codeAndSuffix['suffix'] });
	});

	return map;
}

function getArrivalsByTripAndHour(stop) {
	var arrivals = getArrivalsByTrip(stop);

	var timeByHour;
	var hourAndMinute;
	var arrival;
	for (var trip in arrivals) {
		timeByHour = {};
		for (var i in arrivals[trip]) {
			arrival = arrivals[trip][i];
			hourAndMinute = parseTimestamp(arrival.time);

			if (!timeByHour[hourAndMinute[0]])
				timeByHour[hourAndMinute[0]] = [];

			timeByHour[hourAndMinute[0]].push({ minute: hourAndMinute[1], suffix: arrival.suffix });

		}
		arrivals[trip] = timeByHour;
	}

	return arrivals;
}
