port module Stylesheets exposing (..)

import Apps.Style as Apps
import Core.Style as Core
import Css.File exposing (CssCompilerProgram, CssFileStructure)
import Landing.Style as Landing
import OS.Console.Style as Console
import OS.Header.Style as Header
import OS.Style as OS
import OS.Toasts.Style as Toasts
import OS.WindowManager.Dock.Style as Dock
import OS.WindowManager.Sidebar.Style as Sidebar
import OS.WindowManager.Style as WindowManager
import Setup.Style as Setup
import UI.Style as UI


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "index.css"
          , Css.File.compile
                ([ Core.css
                 , Landing.css
                 , Setup.css
                 , Header.css
                 , Console.css
                 , Toasts.css
                 , OS.css
                 , UI.css
                 , WindowManager.css
                 , Dock.css
                 , Sidebar.css
                 ]
                    ++ Apps.cssList
                )
          )
        ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
