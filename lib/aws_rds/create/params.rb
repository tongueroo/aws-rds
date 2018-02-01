class AwsRds::Create
  class Params
    def initialize(options)
      @options = options
    end

    def generate
      params = AwsRds::Profile.new(@options).load
      params = use_database_cli_options(params)
      params = set_security_groups(params)
      params = set_db_subnet_group(params)
      params.symbolize_keys
    end

    # Be able to set the common database options with the CLI options.
    # Other options can be set with the profile files.
    def use_database_cli_options(params)
      params['db_instance_identifier'] = @options[:name] # required
      params['db_name'] = @options[:db_name] if @options[:db_name]
      params['master_username'] = @options[:db_user] if @options[:db_user]
      params['master_user_password'] = @options[:db_password] if @options[:db_password]
      params
    end

    def set_security_groups(params)
      return params if @options[:noop]
      # dont create SG if user has set one
      #   db_security_groups: classic RDS db security groups, separtae groups from
      #   from ec2 security groups.
      #   vpc_security_group_ids: vpc security groups. same groups as what the ec2
      #   security groups use.
      # db_security_groups is not really recommended anymore because it is the
      # EC2-classic network.
      return params if params['vpc_security_group_ids'] || params['db_security_groups']

      security_group_name = @options[:security_group_name] || @options[:name]
      sg = AwsRds::SecurityGroup.find_or_create(security_group_name)
      params['vpc_security_group_ids'] ||= [sg.group_id]
      params
    end

    def set_db_subnet_group(params)
      params["db_subnet_group_name"] ||= fallback_db_subnet_group_name
      params
    end

    def fallback_db_subnet_group_name
      AwsRds.config["fallback"]["db_subnet_group_name"]
    rescue NoMethodError => e
      puts e.message
      puts <<-EOL
No db_subnet_group_name was specified in your profile. Also, a fallback db subnet group name was set.

Please add a db_subnet_group_name in your profile file or add a fallback db_subnet_group_name to your config/#{AwsRds.env}.yml.

To specify a fallback db_subnet_group_name setting. Example config/#{AwsRds.env}.yml:

---
fallback:
  db_subnet_group_name: my-db-subnet-group
EOL
      exit 1
    end
  end
end
