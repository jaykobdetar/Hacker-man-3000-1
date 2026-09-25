module Decoders.Inventory exposing (..)

import Decoders.Components
import Decoders.Network
import Game.Inventory.Models exposing (..)
import Game.Meta.Types.Components.Specs exposing (Specs)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, hardcoded, required)


inventory : Specs -> Decoder Model
inventory specs =
    decode Model
        |> required "components" (Decoders.Components.components specs)
        |> required "network_connections" Decoders.Network.connections
        |> hardcoded specs
