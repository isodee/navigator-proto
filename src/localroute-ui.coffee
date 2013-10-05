
class LocalRouteUI 
   instance = null

   @set_selected_stop: (stopId) -> 
      console.log "Stop " + stopId + " selected"
      citynavi.recent_stop = stopId
 

window.set_selected_stop = LocalRouteUI.set_selected_stop

test = () -> 
   tmp = "Xxxxxxxx xxxxxxxx xxxxxxxx" 
   tmp = tmp + tmp + tmp + tmp
   tmp = tmp + tmp + tmp + tmp
   tmp = tmp + tmp + tmp + tmp
   tmp = tmp + tmp + tmp + tmp


setContent = () -> 
  $("#stop-query-content-rows").html("<tr><td>8</td><td> </td></tr><tr><td>9</td><td><ul class='stop-hour-times'><li>8</li><li>9</li><li>10</li><li>11</li></ul></td></tr>")

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


