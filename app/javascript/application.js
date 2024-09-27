// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import { Turbo } from "@hotwired/turbo-rails"

import "./controllers/turbo_custom_animations";

import "controllers"

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()



import "channels"
