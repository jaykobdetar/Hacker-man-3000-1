module Driver.Websocket.Models exposing (ApiUrl, EventBase, Model)

import Dict exposing (Dict)
import Json.Decode exposing (Value)
import Phoenix.Channel as Channel
import Phoenix.Socket as Socket


type alias ApiUrl =
    String


type alias Model msg =
    { socket : Socket.Socket msg
    , channels : Channels msg
    }


type alias Channels msg =
    Dict String (Channel.Channel msg)


type alias EventBase =
    { data : Value
    , event : String
    }
