import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  static values = {
    visible: Boolean,
    text: String,
    type: String,
    duration: Number
  };

  connect() {
    this.element.style.transition = "opacity 0.3s ease, transform 0.3s ease";
    if (this.visibleValue) {
      console.log(this.visibleValue)
      this.showToast();
    }
  }

  showToast() {
    // Show the toast with animation
    this.element.classList.remove("opacity-0", "pointer-events-none");
    this.element.classList.add("opacity-100", "pointer-events-auto");

    // Hide after specified duration
    setTimeout(() => {
      this.hideToast();
    }, this.durationValue);
  }

  hideToast() {
    // Hide the toast with animation
    this.element.classList.remove("opacity-100", "pointer-events-auto");
    this.element.classList.add("opacity-0", "pointer-events-none");
  }
}
