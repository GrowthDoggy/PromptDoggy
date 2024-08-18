import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copilot-textarea"
export default class extends Controller {
  static targets = ["input", "suggestion"];
  connect() {
    this.suggestionText = "";
    this.currentInput = "";
    this.cursorPosition = 0;
    this.updateSuggestion = this.updateSuggestion.bind(this);
    this.typingTimer; // Timer identifier
    this.doneTypingInterval = 1000; // Time in ms (1 second)
  }

  onInput(event) {
    this.currentInput = event.target.value;
    this.cursorPosition = event.target.selectionStart;

    clearTimeout(this.typingTimer); // Clear the previous timer

    if (this.currentInput.trim() === "") {
      // Reset suggestion when input is empty
      this.suggestionText = "";
      this.updateSuggestion();
      return; // Do not make a fetch request
    }

    // Start a new timer
    this.typingTimer = setTimeout(() => {
      // Fetch suggestion from the backend
      fetch("/copilots/prompts", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ input: this.currentInput })
      })
          .then(response => response.json())
          .then(data => {
            this.suggestionText = data.following_prompt;
            this.updateSuggestion();
          });
    }, this.doneTypingInterval);
  }

  updateSuggestion() {
    const beforeCursor = this.currentInput.slice(0, this.cursorPosition);
    const afterCursor = this.currentInput.slice(this.cursorPosition);

    this.suggestionTarget.value = beforeCursor + this.suggestionText + afterCursor;
  }

  acceptSuggestion(event) {
    if (event.key === "Tab") {
      event.preventDefault();
      this.inputTarget.value += this.suggestionText;
      this.suggestionText = "";
      this.updateSuggestion();
    }
  }
}
