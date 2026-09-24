module OS.Header.NetworkView exposing (view)

import Game.Meta.Types.Network as Network
import Html exposing (..)
import Html.CssHelpers
import Html.Events exposing (onClick)
import OS.Header.Config exposing (..)
import OS.Header.Messages exposing (..)
import OS.Header.Models exposing (..)
import OS.Header.Resources exposing (..)
import Utils.Html.Attributes exposing (boolAttr)
import Utils.List as List


{ id, class, classList } =
    Html.CssHelpers.withNamespace prefix


view : Config msg -> Bool -> Html msg
view { toMsg, activeNIP, nips } isOpen =
    let
        onClickNetwork nip =
            onClick <| toMsg <| SelectNIP nip

        availableNetworks =
            nips
                |> List.unique
                |> List.filter
                    ((/=) activeNIP)
                |> List.map
                    (\nip ->
                        text (Network.getId nip)
                            |> List.singleton
                            |> li [ onClickNetwork nip ]
                    )
    in
    case availableNetworks of
        [] ->
            text ""

        _ ->
            div [ class [ Network ] ]
                [ div
                    [ class [ ActiveNetwork ]
                    , onClick <| toMsg <| ToggleMenus NetworkOpen
                    ]
                    [ div [] [ text (Network.getId activeNIP) ]
                    , div [] [ text "⌄" ]
                    ]
                , ul
                    [ class [ AvailableNetworks ]
                    , boolAttr expandedMenuAttrTag isOpen
                    ]
                    availableNetworks
                ]
