module Apps.LocationPicker.Update exposing (update)

import Apps.LocationPicker.Config exposing (..)
import Apps.LocationPicker.Messages as LocationPicker exposing (Msg(..))
import Apps.LocationPicker.Models exposing (..)
import Json.Decode exposing (Value)
import Utils.Ports.Geolocation as Geolocation
import Utils.Ports.Leaflet as Leaflet
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update :
    Config msg
    -> LocationPicker.Msg
    -> Model
    -> UpdateResponse msg
update config msg model =
    case msg of
        LeafletMsg id msg ->
            if id == model.mapEId then
                onLeafletMsg config msg model

            else
                ( model, React.none )

        GeolocationMsg id msg ->
            if id == model.self then
                onGeoMsg config msg model

            else
                ( model, React.none )


onLeafletMsg : Config msg -> Leaflet.Msg -> Model -> UpdateResponse msg
onLeafletMsg config msg model =
    case msg of
        Leaflet.Clicked coords ->
            ( setPos (Just coords) model, React.none )

        _ ->
            ( model, React.none )


onGeoMsg : Config msg -> Geolocation.Msg -> Model -> UpdateResponse msg
onGeoMsg config msg model =
    case msg of
        Geolocation.Coordinates coords ->
            Leaflet.center model.mapEId coords 18
                |> React.cmd
                |> (,) model

        _ ->
            ( model, React.none )
