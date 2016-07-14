(function() {
  this.App || (this.App = {});

  App.quarkChannel = App.cable.subscriptions.create({ channel: "QuarkChannel" }, {
    received: function(data) {
      console.log('App.quarkChannel.received', data);
      if (data.status === 'ok') {
        App.counter.add(data.quark.count);
      }
    },
    connected: function() {
      console.log('App.quarkChannel.connected');
      App.counter.ready();
    },
    count: function(count) {
      this.perform('create', { count: count });
    }
  });
}).call(this);
