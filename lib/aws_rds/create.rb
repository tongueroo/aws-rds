require 'yaml'
require 'active_support/core_ext/hash'

module AwsRds
  class Create
    autoload :Params, "aws_rds/create/params"

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

    def params
      @params ||= Params.new(@options).generate
    end

    def pretty_display(data)
      data = data.deep_stringify_keys
      puts YAML.dump(data)
    end
  end
end
