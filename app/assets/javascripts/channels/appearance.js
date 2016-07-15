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
      $('#active-users-list').text(this.activeUsersNamesText(userStats.users));
    },
    activeUsersText: function(total) {
      if (total === 1) {
        return '1 user counting Quarks';
      } else {
        return total + ' users counting Quarks'
      }
    },
    activeUsersNamesText: function(users) {
      if (users.length === 0) {
        return '';
      } else if (users.length === 1) {
        return 'Including ' + this.capitalise(users[0].name);
      } else {
        let names = users.map((user) => {
          return this.capitalise(user.name);
        });
        names[names.length - 1] = 'and ' + names[names.length - 1];
        return 'Including ' + names.join(', ');
      }

    },
    capitalise: function(string) {
      return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
    }
  });
}).call(this);
