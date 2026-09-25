module Setup.Pages.PickLocation.Subscriptions exposing (subscriptions)

import Setup.Pages.PickLocation.Config exposing (..)
import Setup.Pages.PickLocation.Messages exposing (..)
import Setup.Pages.PickLocation.Models exposing (..)
import Utils.Ports.Geolocation as Geolocation
import Utils.Ports.Leaflet as Leaflet


subscriptions : Config msg -> Model -> Sub msg
subscriptions { toMsg } model =
    Sub.batch
        [ Sub.map toMsg <| Leaflet.subscribe LeafletMsg
        , Sub.map toMsg <| Geolocation.subscribe GeolocationMsg
        ]
