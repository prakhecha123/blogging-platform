// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import $ from 'jquery';
import Popper from 'popper.js';
import * as bootstrap from 'bootstrap';

global.$ = $;
global.jQuery = $;
global.Popper = Popper;