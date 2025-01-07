// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./tables/members"
import "./tables/simple"

document.addEventListener('turbo:load', () => {
  const flashMessages = document.querySelectorAll('.flash-container');
  flashMessages.forEach(message => {
    setTimeout(() => {
      message.remove();
    }, 3000);
  });

  const loadingSpinner = document.querySelector('.loading-spinner');
  if (loadingSpinner) {
    setTimeout(() => {
      loadingSpinner.style.display = 'none';
    }, 3000);
  }
});
