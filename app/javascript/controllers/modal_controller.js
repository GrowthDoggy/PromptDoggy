import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["backdrop", "modal"]

    connect() {
        this.hideDialog(); // Ensure the dialog is hidden when the controller is connected
    }

    showDialog() {
        // Remove classes that hide the backdrop and modal
        this.backdropTarget.classList.remove("opacity-0", "pointer-events-none");
        this.modalTarget.classList.remove("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95", "pointer-events-none");

        // Add classes to show the backdrop and modal with animation
        this.backdropTarget.classList.add("opacity-100", "transition-opacity", "ease-linear", "duration-300");
        this.modalTarget.classList.add("opacity-100", "translate-y-0", "sm:scale-100", "transition", "ease-in-out", "duration-300", "transform");
    }

    hideDialog() {
        // Reverse the transition classes
        this.backdropTarget.classList.remove("opacity-100");
        this.modalTarget.classList.remove("opacity-100", "translate-y-0", "sm:scale-100");

        // Add classes to hide the backdrop and modal with animation
        this.backdropTarget.classList.add("opacity-0", "transition-opacity", "ease-linear", "duration-300");
        this.modalTarget.classList.add("opacity-0", "translate-y-4", "sm:translate-y-0", "sm:scale-95", "transition", "ease-in-out", "duration-300", "transform");

        // Use a timeout to fully hide the elements after the transition duration
        setTimeout(() => {
            this.backdropTarget.classList.add("pointer-events-none");
            this.modalTarget.classList.add("pointer-events-none");
        }, 300); // Match this duration to the transition duration
    }
}
