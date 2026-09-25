module Events.Account.Handlers.StoryEmailReplySent exposing (Data, handler)

import Decoders.Storyline exposing (replies, reply, stepWithActions)
import Events.Shared exposing (Handler)
import Game.Storyline.Shared exposing (ContactId, Quest, Reply, Step)
import Game.Storyline.StepActions.Shared exposing (Action)
import Json.Decode
    exposing
        ( Decoder
        , andThen
        , decodeValue
        , float
        , string
        )
import Json.Decode.Pipeline exposing (decode, optional, required)
import Time exposing (Time)


type alias Data =
    { timestamp : Time
    , contactId : ContactId
    , step : ( Quest, Step, List Action )
    , reply : Reply
    , availableReplies : List Reply
    }


handler : Handler Data msg
handler toMsg =
    decodeValue replySent >> Result.map toMsg



-- internals


replySent : Decoder Data
replySent =
    decode Data
        |> required "timestamp" float
        |> required "contact_id" string
        |> required "step" stepWithActions
        |> required "reply_id" reply
        --|> required "reply_to" reply
        |> required "replies" replies
