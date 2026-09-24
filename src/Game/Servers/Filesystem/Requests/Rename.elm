module Game.Servers.Filesystem.Requests.Rename exposing (renameRequest)

import Game.Servers.Filesystem.Shared exposing (..)
import Game.Servers.Shared exposing (CId)
import Json.Encode as Encode exposing (Value)
import Requests.Requests as Requests
import Requests.Topics as Topics
import Requests.Types exposing (Code(..), FlagsSource, ResponseType)


renameRequest : String -> Id -> CId -> FlagsSource a -> Cmd ResponseType
renameRequest newBaseName id cid =
    Requests.request (Topics.fsRename cid)
        (encoder newBaseName id)



-- internals


encoder : String -> Id -> Value
encoder newBaseName id =
    Encode.object
        [ ( "file_id", Encode.string id )
        , ( "basename", Encode.string newBaseName )
        ]
