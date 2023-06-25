document.addEventListener('DOMContentLoaded', function() {
  var editPostButton = document.getElementById('editPostButton');
  var editPostFormContainer = document.getElementById('editPostFormContainer');

  if (editPostButton && editPostFormContainer) {
    editPostButton.addEventListener('click', function() {
      var postId = this.getAttribute('data-post-id');
      var editUrl = '/posts/' + postId + '/edit';

      fetch(editUrl)
        .then(function(response) {
          return response.text();
        })
        .then(function(html) {
          editPostFormContainer.innerHTML = html;
        })
        .catch(function(error) {
          // Handle error
        });
    });
  }
});
