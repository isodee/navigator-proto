
class LocalRouteUI 
   instance = null

   @set_selected_stop: (stopId) -> 
      console.log "Stop " + stopId + " selected"
      citynavi.recent_stop = stopId
 

window.set_selected_stop = LocalRouteUI.set_selected_stop
 
`
localTimetableInit("todo"); // Uses saturday 05.10 always.

// parse format from:
//
//[  
//  { "110":  [ 
//   {  "time":  "10:23" },
//   {  "time":  "10:24" },
//   {  "time":  "10:25" } ] },
//  { "112":  [
//   { "time":  "11:25" }
//   ] }
//  ];
// to 
// [ { "10", [ "23/110, "24/110", "25/110" ]}
//   { "11", [ "25/112" ] },
//   { "12", [ ] }

if(!Object.keys) Object.keys = function(o){
     if (o !== Object(o))
          throw new TypeError('Object.keys called on non-object');
     var ret=[],p;
     for(p in o) if(Object.prototype.hasOwnProperty.call(o,p)) ret.push(p);
     return ret;
}


function convert(timetable, optFilters) {
  var list = [];

  // TODO: first filter only wanted lines  
  var res = {}
  for(i = 0; i<30; i++) {
    res[i] = []
  }
  
  //timetable.forEach(function(tt) {
  for (var route in timetable) {
      //var line = Object.keys(tt)[0]
     
      var line = timetable[route]
      line.forEach(function(t) {
        var tmp = t["time"].split(":")
        var h = +tmp[0]; 
        var m = tmp[1];
        var entry = m + "/" + "<b>" + route + "</b>"

        var p = res[h]
   	p.push(entry)
      }) 
  }
  // TODO: sort times
  for(i=0; i<30; i++) { 
   res[i] = res[i].sort()
  }

  // console.info(res)       
  return res;
}

function get_html(tables) {
  var html = ""
  Object.keys(tables).forEach(function(time) {
    html += "<tr><td>" + time + "</td>" 
    html += "<td><ul class='stop'>" 
    
    tables[time].forEach(function(line) {
       html += "<li class='stop'>" + line + "</li>"
    })
    html += "</ul></td></tr>"
  })
  
  return html;
}
`

setContent = () -> 
  stops = getStopById(citynavi.recent_stop)
  arrivals = getArrivalsByTrip(stops)
  console.log(arrivals)
  $("#stop-query-content-rows").html(get_html(convert(arrivals)))

$(document).bind "pagebeforechange", (e, data) ->
    if typeof data.toPage != "string"
        return
    u = $.mobile.path.parseUrl(data.toPage)
    if u.hash == "#stop-query"
      console.log "pagebefore change stop-query " + u.hash
      $("#stop-query-header").html(citynavi.recent_stop)
      setContent()

$('#stop-query').bind 'pageshow', (e, data) ->
    console.log "page show stop-query"    
    setContent()
#   $("#stop-query-header").html(citynavi.recent_stop)


