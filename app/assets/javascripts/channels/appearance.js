(function() {
  this.App || (this.App = {});

  App.appearanceChannel = App.cable.subscriptions.create({ channel: 'AppearanceChannel' }, {
    received: function(data) {
      console.log('App.appearanceChannel.received', data);
      this.render(data);
    },
    connected: function() {
      console.log('App.appearanceChannel.connected');
      this.perform('list');
    },
    render: function(userStats) {
      $('#active-users').text(this.activeUsersText(userStats.total_online));
      $('#active-users-list').text(this.activeUsersNamesText(userStats.users, userStats.anonymous_online));
    },
    activeUsersText: function(total) {
      if (total === 1) {
        return '1 user clicking Quarks';
      } else {
        return total + ' users clicking Quarks'
      }
    },
    activeUsersNamesText: function(users, anonymous_online) {
      anonymous_online = parseInt(anonymous_online);
      if (users.length === 0 && anonymous_online === 0) {
        return '';
      } else {
        var names = users.map(function(user) {
          return App.appearanceChannel.capitalise(user.name);
        });
        var namesText = names.length ? names.join(', ') + ' and' : '';
        var anonymousText = anonymous_online === 1 ? 'anonymous person' : 'anonymous people';
        return 'Including ' + namesText + ' ' + anonymous_online + ' ' +  anonymousText;
      }

    },
    capitalise: function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }
  });
}).call(this);
