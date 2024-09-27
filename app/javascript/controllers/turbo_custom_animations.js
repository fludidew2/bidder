// app/javascript/controllers/turbo_custom_animations.js

document.addEventListener("turbo:before-stream-render", function(event) {
    // Get the Turbo Stream element being added
    const newElement = event.target.templateContent.firstElementChild;
   
  
    // Check if the action is "prepend" or "append" to detect new elements being added
    if (event.target.action === "prepend" || event.target.action === "append") {
      // Add an animation class to the new element
      newElement.classList.add("new-post");
    }
  });
  

  document.addEventListener("animationend", function(event) {
    if (event.animationName === "slideIn") {
      event.target.classList.remove("new-post");
    }
  });