// app/javascript/controllers/search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  async autocomplete() {
    const q = this.inputTarget.value.trim()
    if (q.length < 2) { this.resultsTarget.innerHTML = ""; return }

    const res = await fetch(`/books/search?q=${encodeURIComponent(q)}`)
    const items = await res.json()
    this.resultsTarget.innerHTML = items.map(i =>
      `<li><a href="/books/${i.id}" data-turbo="true">${i.title}</a></li>`
    ).join("")
  }
}
