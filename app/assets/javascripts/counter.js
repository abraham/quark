// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function() {
  this.App || (this.App = {});
  const COUNTER_ID = 'counter';

  App.counter = {
    onSubmit: function(event)  {
      App.quarkChannel.count(1);
      return false;
    },
    ready: function() {
      $('form.counter').on('submit', this.onSubmit);
    },
    add: function(increase) {
      var current = document.getElementById(COUNTER_ID).innerText;
      this.render(increase + parseInt(current));
    },
    render: function(count)  {
      var counter = document.getElementById(COUNTER_ID);
      counter.innerText = count;
    }
  }
}).call(this);
