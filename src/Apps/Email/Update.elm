module Apps.Email.Update exposing (update)

import Apps.Email.Config exposing (..)
import Apps.Email.Messages as Email exposing (Msg(..))
import Apps.Email.Models exposing (..)
import Apps.FloatingHeads.Models as FloatingHeads
import Apps.Params as AppParams
import Utils.React as React exposing (React)


type alias UpdateResponse msg =
    ( Model, React msg )


update :
    Config msg
    -> Email.Msg
    -> Model
    -> UpdateResponse msg
update config msg model =
    case msg of
        -- -- Context
        SelectContact email ->
            onSelectContact config email model


onSelectContact : Config msg -> String -> Model -> UpdateResponse msg
onSelectContact { onOpenApp } email model =
    email
        |> FloatingHeads.OpenAtContact
        |> AppParams.FloatingHeads
        |> onOpenApp
        |> React.msg
        |> (,) model
