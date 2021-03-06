// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require slick-carousel/slick/slick.js
//= require intro.js/intro.js
//= require react
//= require react_ujs
//= require components
//= require_tree .


$(function() {
  $('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 15, // Creates a dropdown of 15 years to control year
    format: 'd.m.yyyy',
    onStart: function() {
      // initial format 2001-2-3
      var input = this.$node.val();
      if (input === '') {
        return;
      }

      var parts = input.split('-');
      this.$node.val(parts[2] + '.' + parts[1] + '.' + parts[0]);
    }
  });

  $('.slick').slick();
  if ($('html').hasClass('intro-autostart')) {
    introJs().start();
  }

  $('.intro-start').on('click', function () {
    introJs().start();
  });

});
