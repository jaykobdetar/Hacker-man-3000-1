module Tests exposing (..)

import Apps.Browser.ModelTest as BrowserModel
import Apps.Explorer.ModelTest as ExplorerModel
import Expect
import Fuzz exposing (int, list, string, tuple)
import Game.Account.IntegrationTest as AccountIntegration
import Game.Meta.Type.MotherboardTest as MotherboardTest
import Game.Servers.Filesystem.ModelTest as FilesystemModel
import Game.Servers.Logs.ModelTest as LogsModel
import Game.Servers.Processes.IntegrationTest as ProcessIntegration
import Game.Servers.Processes.ModelTest as ProcessesModel
import String
import Test exposing (..)


all : Test
all =
    describe "heborn"
        [ FilesystemModel.all
        , LogsModel.all
        , ProcessesModel.all
        , BrowserModel.all
        , ExplorerModel.all
        , AccountIntegration.all
        , ProcessIntegration.all
        , MotherboardTest.all
        ]
