(function() {
  this.App || (this.App = {});

  App.toast = {
    _upgraded: false,
    _pending: [],
    queue: function(toast) {
      // Wait until MDL has upgraded the dom and make the Snackbar API available.
      if (App.toast._upgraded) {
        App.toast.render(toast);
      } else {
        App.toast._pending.push(toast);
      }
    },
    element: function() {
      return document.querySelector('#snackbar');
    },
    render: function(toast) {
      App.toast.element().MaterialSnackbar.showSnackbar(toast);
    },
    ready: function() {
      App.toast._upgraded = true;
      App.toast._pending.forEach(App.toast.render);
    }
  }

  // Once MDL has upgraded the dom, process queued toasts.
  $(document).on('mdl-componentupgraded', '#snackbar', App.toast.ready);
}).call(this);
