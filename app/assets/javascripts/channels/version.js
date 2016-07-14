(function() {
  this.App || (this.App = {});

  App.versionChannel = App.cable.subscriptions.create({ channel: 'VersionChannel' }, {
    received: function(data) {
      console.log('App.versionChannel.received', data);
      this.compareVersion(data.version);
    },
    connected: function() {
      console.log('App.versionChannel.connected');
      this.perform('get');
    },
    compareVersion: function(version) {
      if (this.currentVersion() !== version) {
        App.toast.render({
          message: 'There is a new app version available',
          timeout: 60 * 1000,
          actionHandler: () => location.reload(),
          actionText: 'Update'
        });
      }
    },
    currentVersion: function() {
      return $('meta[name=version]').attr('content');
    }
  });
}).call(this);
