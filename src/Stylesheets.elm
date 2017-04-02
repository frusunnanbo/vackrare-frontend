port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Styles
import TitlePageStyles


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "styles.css", Css.File.compile [ Styles.css, TitlePageStyles.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
