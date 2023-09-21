import { Controller } from "@hotwired/stimulus";
// Connects to data-controller="places"
export default class extends Controller {
  static values = { apiKey: String };

  static targets = ["input"];

  googleApiInitialized = false;

  connect() {
    console.log("hi from places controller");
    this.loadGoogleMapsAPI();
  }

  loadGoogleMapsAPI() {
    if (this.googleApiInitialized) return;
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&libraries=places&callback=initMap`;

    script.async = true;

    window.initMap = () => {
      this.initializeAutocomplete();
    };

    document.head.appendChild(script);

    this.googleApiInitialized = true;
  }

  initializeAutocomplete() {
    const input = this.inputTarget;
    const options = {
      types: ["geocode"],
    };

    new google.maps.places.Autocomplete(input, options);

  }
}

// https://developers.google.com/maps/documentation/javascript/place-autocomplete
