(function() {
  this.App || (this.App = {});

  App.toast = {
    _upgraded: false,
    _pending: [],
    queue: function(toast) {
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
      App.toast._pending.forEach(function(toast) { App.toast.render(toast) });
    }
  }

  $(document).on('mdl-componentupgraded', '#snackbar', App.toast.ready);
}).call(this);
