import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["confirm"]

  confirm(event) {
    const userName = this.element.dataset.userName
    const message = `Are you sure you want to delete ${userName}? This action cannot be undone.`

    if (!confirm(message)) {
      event.preventDefault()
      return false
    }

    // Submit the form via DELETE method
    const form = this.element.closest('form')
    if (form) {
      event.preventDefault()
      
      // Add method override for Rails
      const methodInput = document.createElement('input')
      methodInput.type = 'hidden'
      methodInput.name = '_method'
      methodInput.value = 'delete'
      
      form.appendChild(methodInput)
      
      // Add CSRF token if missing
      const csrfToken = document.querySelector('meta[name="csrf-token"]')
      if (csrfToken && !form.querySelector('input[name="authenticity_token"]')) {
        const tokenInput = document.createElement('input')
        tokenInput.type = 'hidden'
        tokenInput.name = 'authenticity_token'
        tokenInput.value = csrfToken.content
        form.appendChild(tokenInput)
      }
      
      form.submit()
    }
  }
}