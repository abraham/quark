(function() {
  this.App || (this.App = {});

  App.versionChannel = App.cable.subscriptions.create({ channel: 'VersionChannel' }, {
    received: (data) => {
      console.log('App.versionChannel.received', data);
      App.versionChannel.compareVersion(data.sha1);
    },
    connected: () => {
      console.log('App.versionChannel.connected');
      App.versionChannel.send({ action: 'get' });
    },
    compareVersion: (version) => {
      if (App.versionChannel.currentVersion() !== version) {
        App.toast.render({
          message: 'There is a new app version available',
          timeout: 30 * 1000,
          actionHandler: () => location.reload(),
          actionText: 'Update'
        });
      }
    },
    currentVersion: () => {
      return $('meta[name=version]').attr('content');
    }
  });
}).call(this);
