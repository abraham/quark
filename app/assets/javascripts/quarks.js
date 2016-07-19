// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function() {
  this.App || (this.App = {});

  const COUNTER_ID = '#counter';
  const INPUT_ID = '#quark_count';
  const FORM_ID = '#new_quark'

  App.quarks = {
    onSubmit: function(event)  {
      var value = $(this).find(INPUT_ID).val();
      App.quarks.disableSubmit();
      App.quarksChannel.count(1);
      return false;
    },
    ready: function() {
      $(FORM_ID).on('submit', this.onSubmit);
    },
    add: function(increase) {
      var current = $(COUNTER_ID)[0].innerText;
      this.renderTotal(increase + parseInt(current));
    },
    renderTotal: function(count)  {
      var counter = $(COUNTER_ID)[0];
      counter.innerText = count;
    },
    disableSubmit: function() {
      // This is just to prevent scripts from submitting every millisecond
      $(FORM_ID).find('button')[0].setAttribute('disabled', 'disabled');
      setTimeout(App.quarks.enableSubmit, 50);
    },
    enableSubmit: function() {
      $(FORM_ID).find('button')[0].removeAttribute('disabled');
    }
  }
}).call(this);
