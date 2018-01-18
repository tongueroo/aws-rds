The create command creates an RDS database with a profile file with some pre-configured parameters in the profiles folder.  If a profile does not exist, it will only use the `profiles/default.yml` parameters.  If a profile exists then it will merged specified profile with the default profile.

For example, say you have:

* profiles/default.yml
* profiles/my-db.yml

Then `my-db.yml` gets combined with `default.yml` profile.  The `default.yml` takes the lowest precedence.

Examples:

$ aws-rds create my-db --profile my-db

By convention, the profile is name of the db.  So the command above can be shortened to:

$ aws-rds create my-db
