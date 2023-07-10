import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places"
export default class extends Controller {

  static targets = ['input'];

  connect() {
     console.log("hi from places controller");
     this.loadGoogleMapsAPI().then(() => {
      this.initializeAutocomplete();
    });
  }

  loadGoogleMapsAPI() {
    return new Promise((resolve, reject) => {
      if (window.google && window.google.maps) {
        resolve();
      } else {
        const script = document.createElement('script');
        script.src = `https://maps.googleapis.com/maps/api/js?key=${process.env.googlemap_api_key}&libraries=places`;
        script.defer = true;
        script.onload = resolve;
        script.onerror = reject;
        document.head.appendChild(script);
      }
    });
  }

  initializeAutocomplete() {
    const input = this.inputTarget;
    const options = {
      types: ['geocode'],
    };

    new google.maps.places.Autocomplete(input, options).addListener('place_changed', () => {
      const place = autocomplete.getPlace();
      console.log(place);
    });
  }
}
