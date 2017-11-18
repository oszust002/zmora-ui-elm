port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Css.ServerTime as ServerTime
import Css.App as App


port files : CssFileStructure -> Cmd msg


fileStructure : CssFileStructure
fileStructure =
    Css.File.toFileStructure
        [ ( "styles.css", Css.File.compile [ App.css, ServerTime.css ] ) ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
