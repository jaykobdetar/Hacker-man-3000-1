module Setup.Messages exposing (..)

import Game.Servers.Shared as Servers
import Json.Encode exposing (Value)
import Setup.Pages.Mainframe.Messages as Mainframe
import Setup.Pages.PickLocation.Messages as PickLocation
import Setup.Requests.SetServer as SetServerRequest
import Setup.Requests.Setup as SetupRequest
import Setup.Settings exposing (SettingTopic, Settings)


type Msg
    = NextPage (List Settings)
    | PreviousPage
    | MainframeMsg Mainframe.Msg
    | PickLocationMsg PickLocation.Msg
    | HandleJoinedAccount Value
    | HandleJoinedServer Servers.CId
    | SetServerRequest SetServerRequest.Data
    | SetupRequest SetupRequest.Data
