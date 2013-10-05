
class LocalRouteUI 
   instance = null

   @set_selected_stop: (stopId) -> 
      console.log "Stop " + stopId + " selected"
      citynavi.recent_stop = stopId
 

window.set_selected_stop = LocalRouteUI.set_selected_stop


