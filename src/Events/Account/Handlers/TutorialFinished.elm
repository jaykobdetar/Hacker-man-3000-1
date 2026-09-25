module Events.Account.Handlers.TutorialFinished exposing (Data, handler)

import Events.Shared exposing (Handler)
import Json.Decode
    exposing
        ( Decoder
        , andThen
        , bool
        , decodeValue
        , field
        , list
        , map
        )
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Data =
    { completed : Bool }


handler : Handler Data msg
handler toMsg =
    decodeValue tutorialFinished >> Result.map toMsg



-- internals


tutorialFinished : Decoder Data
tutorialFinished =
    decode Data
        |> required "tutorial_complete" bool
