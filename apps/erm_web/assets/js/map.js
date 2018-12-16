import L from "leaflet"
import { Socket } from "phoenix"

const guardian_token = $('meta[name="guardian_token"]').attr('content')
let socket = new Socket("/socket", { params: { guardian_token: guardian_token } })
//let socket = new Socket("/socket")

let mapContainer = document.querySelector("#mapid")
let myMap = null
let map;

socket.connect()


if (mapContainer) {
    map = L.map('mapid');
    //console.log(map)

    //map = L.map('mapid').setView([51.505, 30], 18);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        
        id: 'mapbox.streets',
        //maxZoom: 15,
        minZoom: 3,
        accessToken: 'pk.eyJ1IjoidGllcnJhbGlicmUiLCJhIjoiY2preHo4bDM0MGN2djN2cjBzOHN3bTR1bCJ9.TunGBy7jq9N_X6hFM7WRcQ'
    }).addTo(map);

    map.setView([52.2789, 4.9378], 10);

    let channel = socket.channel("map:lobby", {})
    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("entity:list", payload => {
        console.log("eis:list:payload")
        //console.log(payload)
        payload.data.map(entity => {
                console.log(entity.geom)
                var myStyle = {
                    "color": "#ff7800",
                    "weight": 5,
                    "opacity": 0.65
                };
                
                L.geoJSON(entity.geom, {
                    style: myStyle
                }).addTo(map);
            }) 
        
    })

    function centerLeafletMapOnMarker(map, marker) {
        var latLngs = [ marker.getLatLng() ];
        var markerBounds = L.latLngBounds(latLngs);
        map.fitBounds(markerBounds);
      }

    //function markerOnClick(e)
    //{
        //console.log(e.target.options.entity_id)
        //channel.push("ei:selected", {ei_id: e.target.options.ei_id})
    //}

    channel.on("entity:selected", payload => {
        console.log("ei:selected")
        console.log(payload)
        //let liveDiv = $("#live-div")
        //if(liveDiv){
        //    console.log(liveDiv)
        //    liveDiv.empty()
        //    liveDiv.append(payload.html)
        //}else {
        //    console.log("no liveDiv")
        //}
    })
}




export default map