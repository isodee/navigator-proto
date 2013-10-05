
class LocalRouteUI 
   instance = null

   @set_selected_stop: (stopId) -> 
      console.log "Stop " + stopId + " selected"
      citynavi.recent_stop = stopId
 

window.set_selected_stop = LocalRouteUI.set_selected_stop


$(document).bind "pagebeforechange", (e, data) ->
    if typeof data.toPage != "string"
        return
    u = $.mobile.path.parseUrl(data.toPage)
    if u.hash == "#stop-query"
      console.log "pagebefore change stop-query " + u.hash
      $("#stop-query-header").html(citynavi.recent_stop)
      $("#stop-query-content").html(citynavi.recent_stop)

$('#stop-query').bind 'pageshow', (e, data) ->
    console.log "page show stop-query"
#    $("#stop-query-header").html(citynavi.recent_stop)
#    $("#stop-query-content").html(citynavi.recent_stop + "JABA")

