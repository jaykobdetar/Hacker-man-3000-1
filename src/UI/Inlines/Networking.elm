module UI.Inlines.Networking exposing (addr, file, user)

import Game.Meta.Types.Network exposing (IP)
import Game.Shared exposing (ServerUser, isLocalHost, isRoot)
import Html exposing (Attribute, Html, node, text)
import Html.Events exposing (onClick)
import Utils.Html.Attributes exposing (boolAttr)


addr : (IP -> msg) -> IP -> Html msg
addr click addr =
    node "linkAddr"
        [ boolAttr "localhost" (isLocalHost addr)
        , onClick (click addr)
        ]
        [ node "ico" [] []
        , text " "
        , node "label" [] [ text addr ]
        ]


user : ServerUser -> Html msg
user user =
    node "linkUser"
        [ boolAttr "root" (isRoot user) ]
        [ node "ico" [] []
        , text " "
        , node "label" [] [ text user ]
        ]


file : String -> Html msg
file fileName =
    node "linkFile" [] [ text fileName ]
