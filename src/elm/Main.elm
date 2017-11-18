module Main exposing (..)

import Html exposing (..)
import Time exposing (second, Time)
import Html.Attributes as Attributes exposing (..)
import Html.Events exposing (onClick)
import Routes exposing (..)
import Material
import Date.Extra.Format exposing (isoTimeFormat)
import Material.Grid as Grid exposing (..)
import Material.Chip as Chip
import Material.Icon as Icon
import Material.Button as Button
import Material.Typography as Typo
import Material.Options as Options exposing (Property)
import Material.Color as Color
import Material.Icon as Icon
import Msgs exposing (Msg(..))
import Breadcrumbs
import Css.App exposing (appNamespace, AppCss(..))
import Utils exposing (timeToString)
import Material.Typography as Typography
import ServerTime
import Model exposing (..)
import Window
import Material.List as MList
import Utils exposing (onPreventDefaultClick)


-- component import example

import Components.Hello exposing (hello)
import Navigation exposing (Location)


-- APP


{ id, class, classList } =
    appNamespace


main : Program Flags Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> Location -> ( Model, Cmd Msg )
init flags location =
    let
        currentRoute =
            parseLocation location
    in
        Debug.log (toString currentRoute)
            ( initialModel (initialAppOptions flags) currentRoute, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every second Tick
        , Window.resizes (\size -> Resize size.width size.height)
        ]



-- MODEL
-- UPDATE


setAppOptions : Model -> AppOptions -> Model
setAppOptions model options =
    { model | appOptions = options }


toggleTime : AppOptions -> AppOptions
toggleTime options =
    { options | showChip = (not options.showChip) }


setTime : AppOptions -> Time -> AppOptions
setTime options newTime =
    { options | time = newTime }


setSize : AppOptions -> Int -> Int -> AppOptions
setSize options width height =
    { options | width = width, height = height }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Increment ->
            ( { model | number = model.number + 1 }, Cmd.none )

        NewUrl url ->
            ( model, Navigation.newUrl url )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                Debug.log (toString newRoute)
                    ( { model | route = newRoute }, Cmd.none )

        Mdl mdlMsg ->
            Material.update Mdl mdlMsg model

        ToggleTime ->
            ( (model.appOptions
                |> toggleTime
                |> setAppOptions model
              )
            , Cmd.none
            )

        Tick time ->
            ( time
                |> setTime model.appOptions
                |> setAppOptions model
            , Cmd.none
            )

        Resize width height ->
            ( setSize model.appOptions width height
                |> setAppOptions model
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ headerView model
        , grid
            [ Options.css "padding" "16px"
            , Grid.noSpacing
            ]
            [ cell
                [ Grid.size Phone 12
                , Grid.size Tablet 12
                , Grid.size Desktop 3
                ]
                [ MList.ul [ Options.attribute (class [ NavListFlex ]) ]
                    [ navigationItemView [] "/" "inbox" "Home"
                    , navigationItemView [] "/contests" "inbox" "Contests"
                    , navigationItemView [] "/about" "inbox" "About us"
                    ]
                ]
            , cell
                [ Grid.size Phone 12
                , Grid.size Tablet 12
                , Grid.size Desktop 9
                ]
                [ div [ style [ ( "background-color", "yellow" ) ] ] []
                ]
            ]
        ]


navigationItemView : List (Property c Msg) -> String -> String -> String -> Html Msg
navigationItemView style url icon title =
    MList.li
        ([ Options.cs "ripple"
         , Options.attribute (class [ NavListItem ])
         ]
            ++ style
        )
        [ MList.content
            [ Options.attribute <| Html.Events.onClick (NewUrl url) ]
            [ MList.icon icon []
            , text title
            ]
        ]


headerView : Model -> Html Msg
headerView model =
    header
        [ Attributes.class "mui-appbar", class [ Header ] ]
        [ grid
            [ Options.attribute (class [ Grid ])
            ]
            [ cell
                [ Grid.size Desktop 2, Grid.size Tablet 3, Options.css "margin" "0" ]
                [ p
                    [ class [ Logo ] ]
                    [ text "Zmora" ]
                ]
            , cell
                [ Grid.size Desktop 6

                -- FIXME: Change to Grid.hide when bug is fixed
                , Options.cs "mdl-cell--hide-tablet"
                , Options.cs "mdl-cell--hide-phone"
                , Grid.align Middle
                , Options.css "margin" "0"
                ]
                [ Breadcrumbs.view model.route [ NotFound ] [ class [ BreadcrumbItem ] ] ]
            , cell
                [ Grid.align Middle, Options.attribute (class [ RightSideIcons ]) ]
                [ grid [ Grid.noSpacing, Options.css "justify-content" "flex-end" ]
                    [ cell
                        [ Grid.align Middle
                        , Options.css "text-align" "right"
                        ]
                        [ ServerTime.view model.mdl model.appOptions ]
                    , cell
                        [ Options.css "width" "32px"
                        , Grid.align Middle
                        ]
                        [ iconButton model
                            [ Options.attribute <| onPreventDefaultClick (NewUrl "/contests")
                            , Button.link "/contests"
                            ]
                            "account_circle"
                        ]
                    , cell
                        [ Options.css "width" "32px"
                        , Grid.align Middle
                        ]
                        [ iconButton model
                            [ Options.attribute <| onPreventDefaultClick (NewUrl "/contests")
                            , Button.link "/contests"
                            ]
                            "account_circle"
                        ]
                    , cell
                        [ Options.css "width" "32px"
                        , Grid.align Middle
                        ]
                        [ iconButton model
                            [ Options.attribute <| onPreventDefaultClick (NewUrl "/contests")
                            , Button.link "/contests"
                            ]
                            "account_circle"
                        ]
                    ]
                ]
            ]
        ]


iconButton : Model -> List (Button.Property Msg) -> String -> Html Msg
iconButton model styles icon =
    Button.render Mdl
        [ 0 ]
        model.mdl
        ([ Button.icon
         , Options.css "font-size" "32px"
         ]
            ++ styles
        )
        [ Icon.i icon ]


page : Model -> Html Msg
page model =
    case model.route of
        Home ->
            view model

        Contests ->
            view model

        NotFound ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
