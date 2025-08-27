import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  autocomplete() {
    const query = this.inputTarget.value.trim()
    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      this.resultsTarget.style.display = "none"
      return
    }

    fetch(`/books/search?q=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        if (data.length === 0) {
          this.resultsTarget.innerHTML = ""
          this.resultsTarget.style.display = "none"
          return
        }

        this.resultsTarget.innerHTML = data.map(item => {
          return `
            <li class="list-group-item d-flex justify-content-between align-items-center list-group-item-action" tabindex="0" onclick="window.location.href='/books/${item.id}'">
              <div>
                <a href="/books/${item.id}" class="fw-bold text-primary text-decoration-none">${item.title}</a>
                <span class="text-muted ms-2">Autor: ${item.author}</span>
              </div>
              <span class="badge bg-info text-dark ms-3">Disponível: ${item.available_quantity}</span>
            </li>
          `
        }).join("")
        this.resultsTarget.style.display = "block"
      })
  }
}