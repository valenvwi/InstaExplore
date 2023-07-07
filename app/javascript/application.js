// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
Turbo.session.drive = false
//= require jquery3

application.debug = false
window.Stimulus = application
export { application }
