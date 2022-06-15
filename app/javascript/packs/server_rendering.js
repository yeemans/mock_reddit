// By default, this pack is loaded for server-side rendering.
// It must expose react_ujs as `ReactRailsUJS` and prepare a require context.

//= require react-server 
//= require components
// Require everything needed for server rendering
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
