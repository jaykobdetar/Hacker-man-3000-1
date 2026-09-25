module Apps.Style exposing (cssList)

import Apps.BackFlix.Style as BackFlix
import Apps.BounceManager.Style as BounceManager
import Apps.Browser.Style as Browser
import Apps.Bug.Style as Bug
import Apps.Calculator.Style as Calculator
import Apps.ConnManager.Style as ConnManager
import Apps.DBAdmin.Style as DBAdmin
import Apps.Email.Style as Email
import Apps.Explorer.Style as Explorer
import Apps.Finance.Style as Finance
import Apps.FloatingHeads.Style as FloatingHeads
import Apps.Hebamp.Style as Hebamp
import Apps.LanViewer.Style as LanViewer
import Apps.LocationPicker.Style as LocationPicker
import Apps.LogViewer.Style as LogViewer
import Apps.ServersGears.Style as ServersGears
import Apps.TaskManager.Style as TaskManager
import Apps.VirusPanel.Style as VirusPanel
import Css exposing (Stylesheet)


cssList : List Stylesheet
cssList =
    [ Explorer.css
    , LogViewer.css
    , Browser.css
    , TaskManager.css
    , DBAdmin.css
    , ConnManager.css
    , Finance.css
    , BounceManager.css
    , Hebamp.css
    , LocationPicker.css
    , LanViewer.css
    , Email.css
    , Bug.css
    , Calculator.css
    , ServersGears.css
    , BackFlix.css
    , FloatingHeads.css
    , VirusPanel.css
    ]
