$('.js-unsubscribe-event-form').on('submit', function (e){
  # Prevent form from being submit
  # Get the right token and put it into the path
  # Do a get request, while adding a spinner
    # On fail: Cancel spinner and alert the error, clear the form
    # On success: Cancel spinner and render a thank you page like message, which replaces the form
});
