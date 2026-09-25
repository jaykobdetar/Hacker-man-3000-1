module Events.Account.Handlers.VirusCollected exposing (Data, handler)

import Decoders.Database exposing (virusCollected)
import Events.Shared exposing (Handler)
import Game.Account.Bounces.Shared exposing (ID)
import Game.Account.Finances.Models exposing (AccountNumber, AtmId)
import Game.Meta.Types.Network exposing (NIP)
import Json.Decode exposing (decodeValue)


type alias Data =
    -- AtmId, AccountNumber, Value received, file_id, server_nip
    ( AtmId, AccountNumber, Int, ID, NIP )


handler : Handler Data msg
handler toMsg =
    decodeValue virusCollected >> Result.map toMsg
