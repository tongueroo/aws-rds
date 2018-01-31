ENV["TEST"] = "1"
ENV["AWS_RDS_ENV"] = "test"
ENV["AWS_RDS_ROOT"] = "spec/fixtures/demo_project"
# Ensures aws api never called. Fixture home folder does not contain ~/.aws/credentails
ENV['HOME'] = "spec/fixtures/home"

require "pp"

root = File.expand_path("../../", __FILE__)
require "#{root}/lib/aws-rds"

module Helpers
  def execute(cmd)
    puts "Running: #{cmd}" if ENV["DEBUG"]
    out = `#{cmd}`
    puts out if ENV["DEBUG"]
    out
  end
end

RSpec.configure do |c|
  c.include Helpers
end
