module AwsRds
  class Profile
    include TemplateHelper

    def initialize(options)
      @options = options
    end

    def load
      return @profile_params if @profile_params

      check!

      @profile_params = load_profile(profile_file)
    end

    def check!
      return if File.exist?(profile_file)

      puts "Unable to find a #{profile_file.colorize(:green)} profile file."
      puts "Please double check that it exists or that you specified the right profile."
      exit # EXIT HERE
    end

    def load_profile(file)
      return {} unless File.exist?(file)

      puts "Using profile: #{file}"
      data = YAML.load(erb_result(file))
      data ? data : {} # in case the file is empty
      data.has_key?("create_db_instance") ? data["create_db_instance"] : data
    end

    def profile_file
      "#{AwsRds.root}/profiles/#{profile_name}.yml"
    end

    def profile_name
      # allow user to specify the path also
      if @options[:profile] && File.exist?(@options[:profile])
        profile = File.basename(@options[:profile], '.yml')
      end

      # conventional profile is the name of the ec2 instance
      profile || @options[:profile] || "default"
    end
  end
end
