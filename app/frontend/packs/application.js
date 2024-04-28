import './stylesheets.scss';
import 'controllers'; // eslint-disable-line import/no-unresolved
import {} from 'jquery-ujs';
import Turbolinks from 'turbolinks';

// Turbolinks.start() needs to be called before React-Rails
Turbolinks.start();

// Support component names relative to this directory:
const componentRequireContext = require.context('components', true);
const ReactRailsUJS = require('react_ujs');

ReactRailsUJS.useContext(componentRequireContext);
