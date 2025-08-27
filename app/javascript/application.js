// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@rails/ujs"

Rails.start();

document.addEventListener("DOMContentLoaded", function() {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  tooltipTriggerList.forEach(function (tooltipTriggerEl) {
    if (tooltipTriggerEl.classList.contains('is-invalid')) {
      new bootstrap.Tooltip(tooltipTriggerEl).show();
    }
  });
});