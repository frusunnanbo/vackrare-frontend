module Slides exposing (slide, max, min)

import Html
import InTheBeginningOfTime
import InTheMeanTime
import TheseDays
import WhatsAWebapp
import ElmOneOOne
import PageNavigation
import PresentationTimer
import FetchingPages


min =
    1


max =
    8


slide number =
    case number of
        1 ->
            InTheBeginningOfTime.render

        2 ->
            InTheMeanTime.render

        3 ->
            TheseDays.render

        4 ->
            WhatsAWebapp.render

        5 ->
            ElmOneOOne.render

        6 ->
            PageNavigation.render

        7 ->
            PresentationTimer.render

        8 ->
            FetchingPages.render

        _ ->
            Html.text "This slide is not supported"
