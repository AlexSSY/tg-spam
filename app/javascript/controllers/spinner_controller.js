import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="spinner"
export default class extends Controller {
  static targets = ["button"];
  static values = { originalText: String };

  connect() {
    // Save the original button text
    this.originalTextValue = this.buttonTarget.innerHTML;
  }

  replaceText() {
    // Replace button text with a spinner
    this.buttonTarget.disabled = true;
    this.buttonTarget.classList.add("opacity-50", "cursor-not-allowed", "relative");
    this.buttonTarget.innerHTML = `
      <div class="inline-block spinner border-2 border-transparent border-t-white border-l-white rounded-full w-3 h-3 animate-spin"></div>
    `;
  }

  restoreText() {
    // Restore the original button text
    this.buttonTarget.disabled = false;
    this.buttonTarget.classList.remove("opacity-50", "cursor-not-allowed", "relative");
    this.buttonTarget.innerHTML = this.originalTextValue;
  }
}
