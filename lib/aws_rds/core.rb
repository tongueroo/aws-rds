module AwsRds
  module Core
    @@config = nil
    def config
      @@config ||= Config.new.settings
    end

    def env
      ENV['AWS_RDS_ENV'] || 'development'
    end

    def root
      ENV['AWS_RDS_ROOT'] || '.'
    end
  end
end
