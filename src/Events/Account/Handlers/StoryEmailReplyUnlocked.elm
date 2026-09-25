module Events.Account.Handlers.StoryEmailReplyUnlocked exposing (Data, handler)

import Decoders.Storyline exposing (replies, replyFromId)
import Events.Shared exposing (Handler)
import Game.Storyline.Shared exposing (Reply)
import Json.Decode
    exposing
        ( Decoder
        , andThen
        , decodeValue
        , field
        , list
        , map
        , string
        )
import Json.Decode.Pipeline exposing (decode, optional, required)


type alias Data =
    { contactId : String
    , replies : List Reply
    }


handler : Handler Data msg
handler toMsg =
    decodeValue newEmail >> Result.map toMsg



-- internals


newEmail : Decoder Data
newEmail =
    decode Data
        |> required "contact_id" string
        |> required "replies" replies
