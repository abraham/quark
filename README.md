# Quark Clicker

Sample Rails 5 ActionCable application.

# Install

Download the source code.

Install Redis.

```
$ brew install redis
```

Install gem dependencies.

```
$ bundle install
```

_If you run into an error installing the `pg` gem first install Postgres with `$ brew install postgresql`_

Run Redis server.

```
$ redis-server
```

Setup the database.

```
$ rails db:migrate
```

Run the server.

```
$ rails server
```
