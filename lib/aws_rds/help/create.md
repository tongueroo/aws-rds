The create command creates an RDS database with a profile file with some pre-configured parameters in the profiles folder.  If a profile does not exist, it will only use the `profiles/default.yml` parameters.  If a profile exists then it will merged specified profile with the default profile.

For example, say you have:

* profiles/default.yml
* profiles/my-db.yml

Then `my-db.yml` gets combined with `default.yml` profile.  The `default.yml` takes the lowest precedence.

Examples:

$ aws-rds create my-db --profile my-db

By convention, the profile is name of the db.  So the command above can be shortened to:

$ aws-rds create my-db

Security Groups:

By default, instead of using the default security group, a new security group is created and associated with the database.

This security group is named the same as the database name by convention.  This can be overridden at with `--security-group-name`.  If the security group already exists, it will use the existing security group that matches the name.

If you do not want to specify the security group name every time, you can configure the security group id in the profile file by setting vpc_security_group_ids.
