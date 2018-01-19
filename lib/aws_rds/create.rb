require 'yaml'
require 'active_support/core_ext/hash'

module AwsRds
  class Create
    include AwsServices

    def initialize(options)
      @options = options
    end

    def run
      puts "Creating RDS database #{@options[:name]} with the following parameters:"
      pretty_display(params)
      if @options[:noop]
        puts "NOOP mode enabled. RDS instance not created."
        return
      end

      resp = rds.create_db_instance(params)
      puts "RDS database #{@options[:name]} created! 🎉"
      puts "Visit https://console.aws.amazon.com/rds/home?#dbinstances to check on the status"
    end

    # params are taken from the profile file
    def params
      params = load_profiles(profile_name)
      params = use_database_cli_options(params)
      params = set_security_groups(params)
      params = set_db_subnet_group(params)
      params.symbolize_keys
    end

    def set_db_subnet_group(params)
      params["db_subnet_group_name"] ||= AwsRds.config["db_subnet_group_name"]
      params
    end

    def set_security_groups(params)
      return params unless @options[:security_group]
      return params if @options[:noop]

      security_group_name = @options[:security_group_name] || @options[:name]
      sg = SecurityGroup.find_or_create(security_group_name)
      params['vpc_security_group_ids'] ||= [sg.group_id]
      params
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

    def load_profiles(profile_name)
      profile_file = "#{root}/profiles/#{profile_name}.yml"
      base_path = File.dirname(profile_file)
      default_file = "#{base_path}/default.yml"

      params_exit_check!(profile_file, default_file)

      defaults = load_profile(default_file)
      params = load_profile(profile_file)
      params = defaults.merge(params)
    end

    def params_exit_check!(profile_file, default_file)
      return if File.exist?(profile_file) or File.exist?(default_file)

      puts "Unable to find a #{profile_file} or #{default_file} profile file."
      puts "Please double check."
      exit # EXIT HERE
    end

    def load_profile(file)
      return {} unless File.exist?(file)

      puts "Using profile: #{file}"
      data = YAML.load_file(file)
      data ? data : {} # in case the file is empty
    end

    def profile_name
      # allow user to specify the path also
      if @options[:profile] && File.exist?(@options[:profile])
        profile = File.basename(@options[:profile], '.yml')
      end

      # conventional profile is the name of the ec2 instance
      profile || @options[:profile] || @options[:name]
    end

    def root
      ENV['AWS_RDS_ROOT'] || '.'
    end

    def pretty_display(data)
      data = data.deep_stringify_keys
      puts YAML.dump(data)
    end
  end
end
