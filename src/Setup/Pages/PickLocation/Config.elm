module Setup.Pages.PickLocation.Config exposing (Config)

import Setup.Pages.PickLocation.Messages exposing (..)
import Setup.Settings as Settings exposing (Settings)


type alias Config msg =
    { onNext : List Settings -> msg
    , onPrevious : msg
    , toMsg : Msg -> msg
    , batchMsg : List msg -> msg
    }
