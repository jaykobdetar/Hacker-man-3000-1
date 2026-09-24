module Gen.Game exposing (..)

import Core.Flags
import Fuzz exposing (Fuzzer)
import Game.Account.Models as Account
import Game.BackFlix.Models as BackFlix
import Game.Inventory.Models as Inventory
import Game.Meta.Models as Meta
import Game.Models exposing (..)
import Game.Servers.Models as Servers
import Game.Storyline.Models as Story
import Game.Web.Models as Web
import Gen.Servers
import Gen.Utils exposing (..)
import Random.Pcg exposing (Generator, andThen, int, list, map, map2)



--------------------------------------------------------------------------------
-- Fuzzers
--------------------------------------------------------------------------------


model : Fuzzer Model
model =
    fuzzer genModel



--------------------------------------------------------------------------------
-- Generators
--------------------------------------------------------------------------------


genModel : Generator Model
genModel =
    let
        game =
            { account =
                Account.initialModel "" "" ""
            , servers =
                Servers.initialModel
            , meta =
                Meta.initialModel
            , story =
                Story.initialModel
            , web =
                Web.initialModel
            , backflix =
                BackFlix.initialModel
            , inventory =
                Inventory.initialModel
            , flags =
                { apiHttpUrl = ""
                , apiWsUrl = ""
                , version = "test"
                , mode = Core.Flags.HE1
                }
            }

        genPairs =
            map2 (,) Gen.Servers.genServerCId

        genGatewayServer =
            genPairs Gen.Servers.genGatewayServer

        genEndpointServer =
            genPairs Gen.Servers.genEndpointServer

        genServers =
            map2 (\gate end -> [ gate, end ])
                genGatewayServer
                genEndpointServer

        insertServer ( id, server ) game =
            let
                isGateway =
                    case server.ownership of
                        Servers.GatewayOwnership _ ->
                            True

                        _ ->
                            False

                servers =
                    Servers.insert id server game.servers

                account =
                    if isGateway then
                        Account.insertGateway id game.account

                    else
                        game.account
            in
            { game
                | servers = servers
                , account = account
            }
    in
    map (List.foldl insertServer game) genServers
