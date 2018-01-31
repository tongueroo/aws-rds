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
      return params unless @options[:security_group]
      return params if @options[:noop]

      security_group_name = @options[:security_group_name] || @options[:name]
      sg = AwsRds::SecurityGroup.find_or_create(security_group_name)
      params['vpc_security_group_ids'] ||= [sg.group_id]
      params
    end

    def set_db_subnet_group(params)
      params["db_subnet_group_name"] ||= AwsRds.config["db_subnet_group_name"]
      params
    end
  end
end
