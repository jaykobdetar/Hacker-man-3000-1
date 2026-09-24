module Apps.TaskManager.Subscriptions exposing (..)

import Apps.TaskManager.Config exposing (Config)
import Apps.TaskManager.Messages exposing (Msg(..))
import Apps.TaskManager.Models exposing (Model)
import Time exposing (Time, second)


subscriptions : Config msg -> Model -> Sub msg
subscriptions config _ =
    Time.every second (Tick >> config.toMsg)
