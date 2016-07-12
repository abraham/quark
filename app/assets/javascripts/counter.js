// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function() {
  this.App || (this.App = {});
  const COUNTER_ID = 'counter';

  App.counter = {
    onQuark: (quark) => {
      console.log('onQuark', quark);
    },
    onSubmit: (event) => {
      App.quarkChannel.count(1);
      return false;
    },
    ready: () => {
      $('form.counter').on('submit', App.counter.onSubmit);
    },
    add: (increase) => {
      let current = document.getElementById(COUNTER_ID).innerText;
      App.counter.render(increase + parseInt(current));
    },
    render: (count) => {
      let counter = document.getElementById(COUNTER_ID);
      counter.innerText = count;
    }
  }
}).call(this);
