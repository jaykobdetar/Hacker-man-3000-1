module Events.Server.Handlers.FileDownloaded exposing (..)

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
    (Decoders.Filesystem.fileEntry
        |> Decoders.Servers.withStorageId
        |> field "file"
        |> decodeValue
    )
        >> Result.map toMsg
