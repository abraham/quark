(function() {
  this.App || (this.App = {});

  App.quarkChannel = App.cable.subscriptions.create({ channel: "QuarkChannel", scope: 'global' }, {
    received: (data) => {
      console.log('App.quarkChannel.received', data);
      if (data.status === 'ok') {
        App.counter.add(data.quark.count);
      }
    },
    connected: () => {
      console.log('App.quarkChannel.connected');
      App.counter.ready();
    },
    count: (count) => {
      App.quarkChannel.send({ count: count });
    }
  });
}).call(this);
