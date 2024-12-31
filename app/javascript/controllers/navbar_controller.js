import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link", "menu", "openIcon", "closeIcon"]

  connect() {
    this.setActiveLink()
  }

  setActiveLink() {
    const currentPath = window.location.pathname
    this.linkTargets.forEach(link => {
      if (link.getAttribute("href") === currentPath) {
        link.classList.add("bg-gray-900", "text-white")
        link.classList.remove("text-gray-300", "hover:bg-gray-700", "hover:text-white")
      } else {
        link.classList.remove("bg-gray-900", "text-white")
        link.classList.add("text-gray-300", "hover:bg-gray-700", "hover:text-white")
      }
    })
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
    this.menuTarget.classList.toggle("block")
    this.openIconTarget.classList.toggle("hidden")
    this.closeIconTarget.classList.toggle("hidden")
  }
}
