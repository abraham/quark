(function() {
  this.App || (this.App = {});

  App.quarkChannel = App.cable.subscriptions.create({ channel: "QuarkChannel" }, {
    updatedAt: new Date(),
    received: function(data) {
      console.log('App.quarkChannel.received', data);
      if (data.status === 'ok') {
        if (data.total_count) {
          App.counter.render(data.total_count);
        } else  if (data.quark) {
          App.counter.add(data.quark.count);
        }
        App.quarkChannel.updatedAt = new Date();
      } else {
        var errors = data.messages || ['Unknown error occurred'];
        errors.forEach(function(message) {
          App.toast.render({ message: message });
        });
      }
    },
    connected: function() {
      console.log('App.quarkChannel.connected');
      App.counter.ready();
    },
    count: function(count) {
      this.perform('create', { count: count });
    },
    onVisibilityChange: function() {
      var fiveMinutesAgo = (new Date()) - 5 * 60 * 1000;
      if (App.quarkChannel.updatedAt.getTime() < fiveMinutesAgo) {
        App.quarkChannel.perform('total_count');
        App.quarkChannel.updatedAt = new Date();
      }
    }
  });

  document.addEventListener("visibilitychange", App.quarkChannel.onVisibilityChange);
}).call(this);
