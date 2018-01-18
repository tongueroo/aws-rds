class AwsRds::Create
  def initialize(options)
    @options = options
  end

  def run
    puts "Creating RDS database #{@options[:name]}"
  end
end
