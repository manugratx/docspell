module Comp.Basic exposing
    ( editLinkLabel
    , editLinkTableCell
    , genericButton
    , horizontalDivider
    , inputRequired
    , linkLabel
    , loadingDimmer
    , primaryBasicButton
    , primaryButton
    , secondaryBasicButton
    , secondaryButton
    , stats
    , tooltipRight
    )

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Styles as S


primaryButton :
    { x
        | label : String
        , icon : String
        , disabled : Bool
        , handler : Attribute msg
        , attrs : List (Attribute msg)
    }
    -> Html msg
primaryButton model =
    genericButton
        { label = model.label
        , icon = model.icon
        , handler = model.handler
        , disabled = model.disabled
        , attrs = model.attrs
        , baseStyle = S.primaryButtonMain ++ S.primaryButtonRounded
        , activeStyle = S.primaryButtonHover
        }


primaryBasicButton :
    { x
        | label : String
        , icon : String
        , disabled : Bool
        , handler : Attribute msg
        , attrs : List (Attribute msg)
    }
    -> Html msg
primaryBasicButton model =
    genericButton
        { label = model.label
        , icon = model.icon
        , handler = model.handler
        , disabled = model.disabled
        , attrs = model.attrs
        , baseStyle = S.primaryBasicButtonMain
        , activeStyle = S.primaryBasicButtonHover
        }


secondaryButton :
    { x
        | label : String
        , icon : String
        , disabled : Bool
        , handler : Attribute msg
        , attrs : List (Attribute msg)
    }
    -> Html msg
secondaryButton model =
    genericButton
        { label = model.label
        , icon = model.icon
        , handler = model.handler
        , disabled = model.disabled
        , attrs = model.attrs
        , baseStyle = S.secondaryButtonMain ++ S.secondaryButton
        , activeStyle = S.secondaryButtonHover
        }


secondaryBasicButton :
    { x
        | label : String
        , icon : String
        , disabled : Bool
        , handler : Attribute msg
        , attrs : List (Attribute msg)
    }
    -> Html msg
secondaryBasicButton model =
    genericButton
        { label = model.label
        , icon = model.icon
        , handler = model.handler
        , disabled = model.disabled
        , attrs = model.attrs
        , baseStyle = S.secondaryBasicButtonMain ++ S.secondaryBasicButtonRounded
        , activeStyle = S.secondaryBasicButtonHover
        }


genericButton :
    { x
        | label : String
        , icon : String
        , disabled : Bool
        , handler : Attribute msg
        , attrs : List (Attribute msg)
        , baseStyle : String
        , activeStyle : String
    }
    -> Html msg
genericButton model =
    let
        attrs =
            if model.disabled then
                [ class model.baseStyle
                , class "disabled"
                , href "#"
                ]
                    ++ model.attrs

            else
                [ class model.baseStyle
                , class model.activeStyle
                , model.handler
                ]
                    ++ model.attrs
    in
    genericLink model.icon model.label attrs


linkLabel :
    { x
        | disabled : Bool
        , label : String
        , icon : String
        , handler : msg
    }
    -> Html msg
linkLabel model =
    let
        styles =
            [ class S.basicLabel
            , class "inline-block md:text-sm my-auto whitespace-nowrap"
            , class "border-blue-500 text-blue-500 "
            , class "dark:border-lightblue-300 dark:text-lightblue-300"
            ]

        hover =
            [ class "hover:bg-blue-500 hover:text-gray-200"
            , class "dark:hover:bg-lightblue-300 dark:hover:text-bluegray-900"
            ]

        attrs =
            if model.disabled then
                [ href "#"
                , class "disabled"
                ]
                    ++ styles

            else
                [ onClick model.handler
                , href "#"
                ]
                    ++ styles
                    ++ hover
    in
    genericLink model.icon model.label attrs


loadingDimmer : Bool -> Html msg
loadingDimmer active =
    div
        [ classList
            [ ( "hidden", not active )
            ]
        , class S.dimmer
        ]
        [ div [ class "text-gray-200" ]
            [ i [ class "fa fa-circle-notch animate-spin" ] []
            , span [ class "ml-2" ]
                [ text "Loading…"
                ]
            ]
        ]


editLinkLabel : msg -> Html msg
editLinkLabel click =
    linkLabel
        { label = "Edit"
        , icon = "fa fa-edit"
        , handler = click
        , disabled = False
        }


editLinkTableCell : msg -> Html msg
editLinkTableCell m =
    td [ class S.editLinkTableCellStyle ]
        [ editLinkLabel m
        ]


stats :
    { x
        | valueClass : String
        , rootClass : String
        , value : String
        , label : String
    }
    -> Html msg
stats model =
    div
        [ class "flex flex-col mx-6"
        , class model.rootClass
        ]
        [ div
            [ class "uppercase text-center"
            , class model.valueClass
            ]
            [ text model.value
            ]
        , div [ class "text-center uppercase font-semibold" ]
            [ text model.label
            ]
        ]


horizontalDivider :
    { label : String
    , topCss : String
    , labelCss : String
    , lineColor : String
    }
    -> Html msg
horizontalDivider settings =
    div [ class "inline-flex items-center", class settings.topCss ]
        [ div
            [ class "h-px flex-grow"
            , class settings.lineColor
            ]
            []
        , div [ class "px-4 text-center" ]
            [ text settings.label
            ]
        , div
            [ class "h-px flex-grow"
            , class settings.lineColor
            ]
            []
        ]


inputRequired : Html msg
inputRequired =
    span [ class "ml-1 text-red-700" ]
        [ text "*"
        ]


tooltipRight : Bool -> String -> Html msg
tooltipRight show msg =
    div
        [ class "absolute bottom-0 right-5 px-2 py-2 rounded-lg z-50 w-40"
        , class "bg-white border"
        , class "text-sm font-thin"
        ]
        [ text msg
        ]



--- Helpers


genericLink : String -> String -> List (Attribute msg) -> Html msg
genericLink icon label attrs =
    a
        attrs
        [ i
            [ class icon
            , classList [ ( "hidden", icon == "" ) ]
            ]
            []
        , span
            [ class "ml-2"
            , classList [ ( "hidden", label == "" ) ]
            ]
            [ text label
            ]
        ]
