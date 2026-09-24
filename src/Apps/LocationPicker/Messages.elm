module Apps.LocationPicker.Messages exposing (Msg(..))

import Utils.Ports.Geolocation as Geolocation
import Utils.Ports.Leaflet as Leaflet


type Msg
    = LeafletMsg Leaflet.Id Leaflet.Msg
    | GeolocationMsg Geolocation.Id Geolocation.Msg
