(function() {
  this.App || (this.App = {});

  App.quarksChannel = App.cable.subscriptions.create({ channel: "QuarksChannel" }, {
    updatedAt: new Date(),
    received: function(data) {
      console.log('App.quarksChannel.received', data);
      if (data.status === 'ok') {
        if (data.total_count) {
          App.counter.render(data.total_count);
        } else  if (data.quark) {
          App.counter.add(data.quark.count);
        }
        App.quarksChannel.updatedAt = new Date();
      } else {
        var errors = data.messages || ['Unknown error occurred'];
        errors.forEach(function(message) {
          App.toast.render({ message: message });
        });
      }
    },
    connected: function() {
      console.log('App.quarksChannel.connected');
      App.counter.ready();
    },
    count: function(count) {
      this.perform('create', { count: count });
    },
    onVisibilityChange: function() {
      var fiveMinutesAgo = (new Date()) - 5 * 60 * 1000;
      if (App.quarksChannel.updatedAt.getTime() < fiveMinutesAgo) {
        App.quarksChannel.perform('total_count');
        App.quarksChannel.updatedAt = new Date();
      }
    }
  });

  document.addEventListener("visibilitychange", App.quarksChannel.onVisibilityChange);
}).call(this);
