// app/javascript/controllers/review_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["ratingInput", "averageLabel", "form"]

  async submitReview(event) {
    event.preventDefault()
    const formData = new FormData(this.formTarget)
    const res = await fetch(this.formTarget.action, {
      method: this.formTarget.method,
      headers: { "Accept": "text/vnd.turbo-stream.html" },
      body: formData
    })
    // Turbo Streams vão atualizar o trecho da média automaticamente
  }
}
