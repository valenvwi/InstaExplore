import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="places"
export default class extends Controller {
  static values = { apiKey: String };

  static targets = ["input"];

  // this is to make sure that the google api is not loaded twice
  googleApiInitialized = false;

  connect() {
    console.log("hi from places controller");
    this.loadGoogleMapsAPI();
  }

  loadGoogleMapsAPI() {
    if (this.googleApiInitialized) return;
    const script = document.createElement("script");
    script.src = `https://maps.googleapis.com/maps/api/js?key=${this.apiKeyValue}&libraries=places&callback=initMap`;
    console.log(script.src);

    // if the script is loading, it doesn't stop the whole page to load
    script.async = true;

    window.initMap = () => {
      this.initializeAutocomplete();
    };

    // this is to make sure that the script is loaded in the head of the html
    document.head.appendChild(script);

    this.googleApiInitialized = true;
  }

  initializeAutocomplete() {
    const input = this.inputTarget;
    const options = {
      types: ["geocode"],
    };

    new google.maps.places.Autocomplete(input, options);
    // const autocomplete = new google.maps.places.Autocomplete(input, options);
    // autocomplete.addListener('place_changed', () => {
    //   const place = autocomplete.getPlace();
    //   console.log(place);
    // });
  }
}

// https://developers.google.com/maps/documentation/javascript/place-autocomplete
