import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  connect() {
    console.log("hi from comment controller");
  }

  static targets = ["commentsdiv"]

  show() {
    if (this.commentsdivTarget.style.display == 'block') {
    this.commentsdivTarget.style.display = "none";
    } else { this.commentsdivTarget.style.display = "block"; }
  }
}
