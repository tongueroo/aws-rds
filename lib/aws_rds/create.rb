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
      pp params
      resp = rds.create_db_instance(params)
      puts "RDS database #{@options[:name]} created! 🎉"
      puts "Visit https://console.aws.amazon.com/rds/home?#dbinstances: to check on the status"
    end

    # params are taken from the profile file
    def params
      profile_file = "#{root}/profiles/#{profile_name}.yml"
      default_file = "#{root}/profiles/default.yml"
      if !File.exist?(profile_file) && !File.exist?(default_file)
        puts "Unable to find a #{profile_file} or #{default_file} profile file."
        puts "Please double check."
        exit
      end

      defaults = load_profile(default_file)
      puts "defaults #{defaults.inspect}"
      params = load_profile(profile_file)
      puts "params #{params.inspect}"
      defaults.merge(params).symbolize_keys
    end

    def load_profile(file)
      return {} unless File.exist?(file)

      data = YAML.load_file(file)
      data ? data : {}
    end

    def profile_name
      # conventional profile is the name of the database
      @options[:profile] || @options[:name]
    end

    def root
      ENV['AWS_RDS_ROOT'] || '.'
    end
  end
end
