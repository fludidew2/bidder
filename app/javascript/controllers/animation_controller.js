import { Controller } from "@hotwired/stimulus";
console.log("Animation Controller Loaded");
export default class extends Controller {
  connect() {
    this.boundHandleBeforeStreamRender = this.handleBeforeStreamRender.bind(this);
    document.addEventListener("turbo:before-stream-render", this.boundHandleBeforeStreamRender);
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.boundHandleBeforeStreamRender);
  }

  handleBeforeStreamRender(event) {
    console.log("Turbo Stream Render Event Triggered:", event);

    // Get the new content from the Turbo Stream event
    const newElement = event.target.templateElement.content.firstElementChild;

    console.log("New Element Being Inserted:", newElement); // Log the new element

    // Check if the new element is a post
    if (newElement && newElement.classList.contains("post")) {
      console.log("Adding animation class to new post element"); // Log when the condition is met
      newElement.classList.add("new-post"); // Add the animation class

      newElement.addEventListener("animationend", () => {
        console.log("Animation ended, removing animation class");
        newElement.classList.remove("new-post");
      });
    } else {
      console.log("New element is not a post or not found");
    }
  }
}