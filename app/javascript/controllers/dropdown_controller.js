import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ["modal", "hiddenInput", "button"];

  connect() {
    this.modalTarget.classList.add("hidden"); // Ensure modal is hidden initially
  }

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }

  select(event) {
    const itemId = event.currentTarget.dataset.itemId;
    const itemText = event.currentTarget.dataset.itemText;

    // Set the hidden input value (if used)
    if (this.hasHiddenInputTarget) {
      this.hiddenInputTarget.value = itemId;
    }

    // Close the dropdown
    this.close();
  }
}
