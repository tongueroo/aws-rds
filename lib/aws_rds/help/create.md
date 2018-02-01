The create command creates an RDS database with pre-configured settings from a profile file.  If a profile is not specified, it will use the `profiles/default.yml` profile.

Examples:

  aws-rds create mydb --profile mydb # uses profiles/mydb.yml

Security Groups:

It is recommended that you configure an explicit security group in your profiles so that the RDS DB does not use the default security group. Using an explicit security group allows you to control access to the DB in a finely tuned manner.

If you do not have an existing security groups and want would like aws-rds to create a security group for you, use the --security-group-name option:

  aws-rds create mydb --profile mydb --security-group-name mydbsg

When using the `--security-group-name` option, you need to set the vpc_id and db_subnet_group_group variables in your config/ENV.yml settings file.  Example config/development.yml:

---
vpc_id: vpc-123
db_subnet_group_group: my-db-subnet-group
