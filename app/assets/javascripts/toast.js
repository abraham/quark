(function() {
  this.App || (this.App = {});

  App.toast = {
    _upgraded: false,
    _pending: [],
    queue: (toast) => {
      if (App.toast._upgraded) {
        App.toast.render(toast);
      } else {
        App.toast._pending.push(toast);
      }
    },
    element: () => {
      return document.querySelector('#snackbar');
    },
    render: (toast) => {
      App.toast.element().MaterialSnackbar.showSnackbar(toast);
    },
    ready: () => {
      App.toast._upgraded = true;
      App.toast._pending.forEach(toast => App.toast.render(toast));
    }
  }

  $(document).on('mdl-componentupgraded', '#snackbar', App.toast.ready);
}).call(this);
