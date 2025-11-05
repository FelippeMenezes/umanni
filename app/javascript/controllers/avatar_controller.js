import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["fileInput", "urlInput"]

  connect() {
    this.clearOppositeInput()
  }

  clearOppositeInput() {
    if (this.fileInputTarget.files && this.fileInputTarget.files.length > 0) {
      this.urlInputTarget.value = ""
    }

    if (this.urlInputTarget.value.trim() !== "") {
      this.fileInputTarget.value = ""
    }
  }

  onFileChange() {
    if (this.fileInputTarget.files && this.fileInputTarget.files.length > 0) {
      this.urlInputTarget.value = ""
    }
  }

  onUrlInput() {
    if (this.urlInputTarget.value.trim() !== "") {
      this.fileInputTarget.value = ""
    }
  }
}
