# AWS RDS Tool

Simple tool to create AWS RDS db instances consistently with pre-configured settings.  The pre-configured settings are stored in files in the profiles folder of the current directory.

For example, say you have:

* profiles/default.yml: default settings, when no profile is specified.
* profiles/mydb.yml: mydb settings.

## Usage

```sh
aws-rds create mydb --profile mydb --db-name mydbname
```

* mydb will be the RDS database identifier show on the AWS console
* mydbname is the database name that contains the tables

In a nutshell, the profile parameters are passed to the ruby aws-sdk [AWS::RDS::Client#create_db_instance](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Client.html#create_db_instance-instance_method) method.  So you can specify any parameter you wish that is available in the aws-sdk.  To check out what a profile looks like view the [example default](example/profiles/default.yml)

## config

You can configure common global settings. The required settings are listed below.  Example:

`config/development.yml`

```yaml
vpc_id: vpc-123 # falls back to this vpc if not specified in the profile
db_subnet_group_name: private-subnet-group-name # fallback db_subnet_group_name whe not set
```

## Security Group Creation

The tool automatically creates a security group and associates it with the newly created db. Normally the default security group is associated with the db. A new security group allows you to control access to the database in finely tune manner without affecting the default security group.

## Convention

By convention, the security-group name is the same as the db identifier.  So if the db identifier matches the commands the be simplified.  Examples:

```
aws-rds create mydb --profile myprofile --security-group-name mydb
aws-rds create mydb --profile myprofile # same as above
```

## More Help

```sh
aws-rds create help
aws-rds help # general help
```

Examples are in the [example](example) folder.  You will have to update settings.

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
