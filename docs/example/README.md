# RDS Profiles

This folder contains RDS profile files that can be used with the [aws-rds](https://github.com/tongueroo/aws-rds) tool to quickly launch RDS instances consistently with some pre-configured settings.

As mentioned in the aws-rds README, the script ultimately uses the parameters in the profile files and pass them to the [create_db_instance](https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws/RDS/Client.html#create_db_instance-instance_method) method of the ruby aws-sdk.  So you can use any parameter available there to configure the RDS instance settings.

Check out [profiles/default.yml](profiles/default.yml) for the common settings.

## Creating RDS Databases

To create your own RDS instance for testing you can run:

```sh
aws-rds create mydb --security-group-name mydbsg
```

## Test Connection

Ssh into an instance that has access to the server and verify that you can connect.

```
ssh ec2-user@ec2-xxx.com # ssh into one of your instances
ping xxx.us-east-1.rds.amazonaws.com # test if you can get through firewall
PGPASSWORD=xxx psql -h xxx.us-east-1.rds.amazonaws.com -U xxx # replace the xxx values with the real values
  # this can be found in profiles/default.yml if you are using the default profile
```
