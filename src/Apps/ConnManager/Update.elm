module Apps.ConnManager.Update exposing (update)

import Apps.ConnManager.Config exposing (..)
import Apps.ConnManager.Messages as ConnManager exposing (Msg(..))
import Apps.ConnManager.Models exposing (Model)
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update :
    Config msg
    -> ConnManager.Msg
    -> Model
    -> UpdateResponse msg
update config msg model =
    case msg of
        -- TODO: Filter
        _ ->
            ( model, React.none )
