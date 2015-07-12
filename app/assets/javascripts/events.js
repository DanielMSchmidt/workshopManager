// TODO: Check if this js is still needed (was used for iframe, whats the current solution?)

$(function() {
  'use strict';

  var getPath = function (token) {
    return '/subscription/' + token + '/remove';
  }, spinner = $('<div id="spinner" class="progress"></div>');

  $('.js-unsubscribe-event-form').submit(function (e){
    e.preventDefault(); // Prevent form from being submit
    var arr, path, promise;

    // Get the right token
    arr = $.map([$('input[name=subscribable_id]'), $('input[name=subscribable_type]'), $('input[name=email]')], function($el){
      return $el.val();
    });
    path = getPath(btoa(arr.join(','))); // put it into the path

    $('.js-unsubscribe-event-form').hide(300, function() {
      $('.js-unsubscribe-event-form').after(spinner); // adding a spinner
      promise = $.get(path);

      promise.done(function(){
        $('#spinner').replaceWith('Fertig!');
      });

      promise.fail(function(error){
        console.error(error);
        $('#spinner').replaceWith('Fehler!');
      });
    });
  });
});
