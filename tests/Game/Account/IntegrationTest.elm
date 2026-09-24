module Game.Account.IntegrationTest exposing (all, passwordAcquired, replyUnlocked)

import Core.Messages as Core
import Dict exposing (Dict)
import Driver.Websocket.Channels exposing (Channel(..))
import Expect
import Fuzz exposing (tuple, tuple3)
import Game.Account.Database.Models exposing (..)
import Game.Account.Messages as Account
import Game.Account.Models as Account
import Game.Messages as Game
import Game.Models as Game
import Game.Servers.Messages as Servers
import Game.Servers.Models as Servers
import Game.Storyline.Models as Story
import Game.Storyline.Shared as Story
import Gen.Game as GenGame
import Gen.Processes as GenProcesses
import Json.Decode as Decode
import Requests.Types exposing (Code(OkCode))
import Test exposing (Test, describe)
import TestUtils exposing (applyEvent, fromJust, fuzz, gameDispatcher, toValue)
import Utils.React as React exposing (React)


all : Test
all =
    describe "account integration tests"
        [ describe "reacting to events"
            eventTests
        ]



--------------------------------------------------------------------------------
-- Event Tests
--------------------------------------------------------------------------------


eventTests : List Test
eventTests =
    [ passwordAcquired
    , replyUnlocked
    ]


passwordAcquired : Test
passwordAcquired =
    fuzz
        GenGame.model
        "event 'server_password_acquired' inserts the password"
    <|
        \game ->
            let
                ( serverId, server ) =
                    fromJust "server_password_acquired fetching gateway" <|
                        Game.getGateway game

                -- building event
                channel =
                    AccountChannel ""

                name =
                    "server_password_acquired"

                json =
                    """
                        { "server_ip": "phoebe"
                        , "password": "asdfasdf"
                        , "network_id": "id"
                        , "process_id": "id"
                        , "gateway_ip": "ip"
                        }
                        """
            in
            game
                |> applyEvent name json channel
                |> Game.getAccount
                |> Account.getDatabase
                |> getHackedServers
                |> Dict.get ( "id", "phoebe" )
                |> Maybe.map getPassword
                |> Expect.equal (Just "asdfasdf")


replyUnlocked : Test
replyUnlocked =
    fuzz
        GenGame.model
        "event 'story_email_reply_unlocked' inserts the password"
    <|
        \game ->
            let
                ( serverId, server ) =
                    fromJust "story_email_reply_unlocked fetching gateway" <|
                        Game.getGateway game

                -- building event
                channel =
                    AccountChannel ""

                name =
                    "story_email_reply_unlocked"

                json =
                    """
                        { "contact_id": "kress"
                        , "replies":
                            [ "welcome" ]
                        }
                        """
            in
            game
                |> applyEvent name json channel
                |> Game.getStory
                |> Story.getContact "kress"
                |> Maybe.map
                    Story.getAvailableReplies
                |> Expect.equal
                    (Just [ Story.Welcome ])
