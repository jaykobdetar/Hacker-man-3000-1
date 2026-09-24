module Events.Account.Handlers.StoryEmailSent exposing (Data, handler, notify)

import Decoders.Storyline exposing (replyFromId)
import Events.Shared exposing (Handler)
import Game.Storyline.Shared exposing (ContactId, PastEmail(FromContact), Reply)
import Json.Decode
    exposing
        ( Decoder
        , andThen
        , bool
        , decodeValue
        , field
        , float
        , list
        , map
        , string
        )
import Json.Decode.Pipeline exposing (custom, decode, optional, required)
import Time exposing (Time)


type alias Data =
    { contactId : ContactId
    , messageNode : ( Time, PastEmail )
    , replies : List Reply
    , createNotification : Bool
    }


handler : Handler Data msg
handler toMsg =
    decodeValue newEmail >> Result.map toMsg


notify : (String -> value) -> (Maybe Time -> value -> msg) -> Data -> msg
notify fromString toMsg { contactId, messageNode } =
    let
        ( time, _ ) =
            messageNode
    in
    toMsg (Just time) <| fromString contactId



-- internals


newEmail : Decoder Data
newEmail =
    decode Data
        |> required "contact_id" string
        |> custom messageNode
        |> optional "replies" replies []
        |> optional "notification" bool True


messageNode : Decoder ( Time, PastEmail )
messageNode =
    decode (,)
        |> required "timestamp" float
        |> custom pastEmail


replies : Decoder (List Reply)
replies =
    string
        |> andThen replyFromId
        |> list


pastEmail : Decoder PastEmail
pastEmail =
    field "email_id" string
        |> andThen
            replyFromId
        |> map FromContact
