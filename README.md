# AWS RDS Tool

Simple tool to create AWS RDS db instances with some pre-configured settings.  The pre-configured settings are stored in profile files in the profiles folder of the current directory.

For example, say you have:

* profiles/default.yml
* profiles/my-db.yml

Then `my-db.yml` gets combined with `default.yml` profile.  The `default.yml` takes the lowest precedence.

## Usage

```sh
$ aws-rds create my-db --profile my-db
```

By convention, the profile is name of the db.  So the command above can be shortened to:

```
$ aws-rds create my-db
```

## Installation

```sh
gem install aws-rds
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
