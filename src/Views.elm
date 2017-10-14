module Views exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Msgs exposing (Msg(..))
import Styles exposing (..)
import Models exposing (Model)
import Route exposing (Route)
import Slides.Home as Home
import Slides.About as About
import Slides.Overview as Overview
import Slides.WhyElm1 as WhyElm1
import Slides.TitleAndImage as TitleAndImage


-- VIEW --


view : Model -> Html Msg
view model =
    let
        getView =
            case model.route of
                Route.Home ->
                    Home.view

                Route.About ->
                    About.view

                Route.Overview ->
                    Overview.view

                Route.WhyElm1_1 ->
                    WhyElm1.view (WhyElm1.init 1)

                Route.WhyElm1_2 ->
                    WhyElm1.view (WhyElm1.init 2)

                Route.WhyElm1_3 ->
                    WhyElm1.view (WhyElm1.init 3)

                Route.WhyElm1_4 ->
                    WhyElm1.view (WhyElm1.init 4)

                Route.WhyElm1_5 ->
                    WhyElm1.view (WhyElm1.init 5)

                Route.Speed ->
                    TitleAndImage.view "Speed" "images/speedcomparison.png" "80%"

                Route.ErrorMessages ->
                    TitleAndImage.view "Error Messages" "images/errormessages.png" "80%"

                Route.SemanticVersioning ->
                    TitleAndImage.view "Enforced Semantic Versioning" "images/elmdiff.png" "50%"

        progressBar =
            progressView model
    in
        div [ posFixed, sansSerif ]
            [ navMenu model
            , elmBorder
            , div [ slideContainerStyle model ] [ getView, navArrows ]
            , progressBar
            ]


posFixed : Attribute Msg
posFixed =
    style [ ( "position", "fixed" ), ( "width", "100%" ) ]


elmBorder : Html Msg
elmBorder =
    div [ elmBorderStyle ]
        [ div [ tenHigh, elmDarkBlue ] []
        , div [ tenHigh, elmLightBlue ] []
        , div [ tenHigh, elmOrange ] []
        , div [ tenHigh, elmGreen ] []
        ]


navArrows : Html Msg
navArrows =
    div [ arrowsContainerStyle ]
        [ i [ arrowStyle, leftArrowStyle, onClick Prev ] []
        , i [ (style [ ( "fontWeight", "bold" ), ( "fontSize", "18pt" ), ( "cursor", "pointer" ) ]), onClick ToggleMenu ] [ text "M" ]
        , i [ arrowStyle, rightArrowStyle, onClick Next ] []
        ]


navMenu : Model -> Html Msg
navMenu model =
    let
        menuItems =
            Route.routeList
                |> List.map (\x -> a [ navMenuAnchorStyle, href ("#/" ++ String.toLower x) ] [ text x ])
    in
        div [ navMenuStyle model ]
            menuItems


progressView : Model -> Html Msg
progressView model =
    div [ progressContainerStyle ]
        [ div [ progressStyle model ] []
        ]
