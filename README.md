# ChassisRepo

ChassisRepo is the repo part of the [Chassis project](https://github.com/ahawkins/chassis) which will be used for MagLev.

## Support Libraries

Chassis is implemented with help from a few smaller libraries. A
unified interface if you do not want to know about such things.

* Errors with [TNT](https://github.com/ahawkins/tnt)
* Object initialization with [Lift](https://github.com/ahawkins/lift)
* Interchangeable objects with [Interchange](https://github.com/ahawkins/interchange)

## Installation

Add this line to your application's Gemfile:

    gem 'chassis_repo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chassis_repo


## Data Access

Chassis includes a
[repository](http://martinfowler.com/eaaCatalog/repository.html) using
the query pattern as well. The repository pattern is perfect because
it does not require knowledge about your persistence layer. It is the
access layer. A null, in-memory, and Redis adapter are included. You
can subclass these adapters to make your own.
`Chassis::Repo::Delegation` can be included in other classes to
delegate to the repository.

Here's an example:

```ruby
class CustomerRepo
  extend Chassis::Repo::Delegation
end
```

Now there are CRUD methods available on `CustomerRepo` that delegate
to the repository for `Customer` objects. `Chassis::Persistence` can
be included in any object. It will make the object compatible with
the matching repo.

```ruby
class Customer
  include Chassis::Persistence
end
```

Now `Customer` responds to `id`, `save`, and `repo`. `repo` looks for
a repository class matching the class name (e.g. `CustomerRepo`).
Override as you see if.

More on my blog
[here](http://hawkins.io/2014/01/pesistence_with_repository_and_query_patterns/).


## Chassis::DirtySession

A proxy object used to track assignments. Wrap an object in a dirty
session to see what changed and what it changed to.

```ruby
Person = Struct.new :name

adam = Person.new 'adam'

session = Chassis::DirtySession.new adam
session.clean? # => true
session.dirty? # => false

session.name = 'Adman'

session.dirty? # => true
session.clean? # => false

session.named_changed? # => true
session.changed # => set of values changed
session.new_values # => { name: 'Adman' }
session.original_values # => { name: 'adam' }

session.reset! # reset everything back to normal
```

## Chassis::Logger

Chassis includes the `logger-better` gem to refine the standard
library logger. `Chassis::Logger` default the `logdev` argument to
`Chassis.stream`. This gives a unified place to assign all output.
The log level can also be controlled by the `LOG_LEVEL` environment
variable. This makes it possible to restart/boot the application with
a new log level without redeploying code.

## Chassis::Observable

A very simple implementation of the observer pattern. It is different
from the standard library implementation for two reasons:

* you don't need to call `changed` for `notify_observers` to work.
* `notify_obsevers` includes `self` as first argument to all observers
* there is only the `add_observer` method.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
