module Events.Server.Handlers.FileAdded exposing (..)

import Decoders.Filesystem
import Decoders.Servers
import Events.Shared exposing (Handler)
import Game.Servers.Filesystem.Shared as Filesystem
import Game.Servers.Shared as Servers
import Json.Decode exposing (decodeValue, field)


type alias Data =
    ( Servers.StorageId, Filesystem.FileEntry )


handler : Handler Data msg
handler toMsg =
    decodeValue
        (field "file" <|
            Decoders.Servers.withStorageId Decoders.Filesystem.fileEntry
        )
        >> Result.map toMsg
