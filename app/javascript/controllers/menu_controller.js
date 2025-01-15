import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    this.hide()
  }

  show() {
    this.contentTarget.style.display = "flex"
  }

  hide() {
    this.contentTarget.style.display = "none"
  }
}
