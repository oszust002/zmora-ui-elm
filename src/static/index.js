// pull in desired CSS/SASS files
require( './styles/styles.css');
require( './styles/ripple.css');

// inject bundled Elm app into div#main
var Elm = require( '../elm/Main' );
Elm.Main.embed( document.getElementById( 'main' ),
  {
    width: window.innerWidth,
    height: window.innerHeight,
    time: Date.now()
  });
