require 'yaml'

module AwsRds
  class Config
    def initialize(path="#{AwsRds.root}/config/#{AwsRds.env}.yml")
      @path = path
    end

    def settings
      YAML.load_file(@path)
    rescue Errno::ENOENT => e
      puts e.message
      puts "The #{@path} does not exist. Please double check that it exists."
      exit
    end
  end
end
