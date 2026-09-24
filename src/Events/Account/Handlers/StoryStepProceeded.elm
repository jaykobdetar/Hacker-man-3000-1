module Events.Account.Handlers.StoryStepProceeded exposing (Data, handler)

import Decoders.Storyline exposing (stepWithActions)
import Events.Shared exposing (Handler)
import Game.Storyline.Shared exposing (ContactId, Quest, Reply, Step)
import Game.Storyline.StepActions.Shared exposing (Action)
import Json.Decode exposing (Decoder, decodeValue, string)
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Data =
    { quest : Quest
    , step : Step
    , actions : List Action
    , contactId : ContactId
    }


handler : Handler Data msg
handler toMsg =
    decodeValue stepProceed >> Result.map toMsg



-- internals


stepProceed : Decoder Data
stepProceed =
    decode (\( q, s, a ) c -> Data q s a c)
        |> required "next_step" stepWithActions
        |> optional "contact_id" string "friend"



-- WARNING: 'contact_id' IS MISSING IN HELIX
