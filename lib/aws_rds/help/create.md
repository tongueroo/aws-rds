The create command creates an RDS database with a profile file with some pre-configured settings.   The profile file is in the profiles folder.  If a profile is not specified, it will only use the `profiles/default.yml` profile.

Examples:

  aws-rds create my-db --profile my-db

Security Groups:

By default, instead of using the default security group, a new security group is created and associated with the database.

This security group's name is the same as database name by convention.  This can be overridden at with `--security-group-name`.  If the security group already exists, it will use the existing security group that matches the name.

If you do not want to specify the security group name every time, you can configure the security group id in the profile file by setting vpc_security_group_ids.
