$:.unshift(File.expand_path("../", __FILE__))
require "aws_rds/version"

module AwsRds
  autoload :Help, "aws_rds/help"
  autoload :Command, "aws_rds/command"
  autoload :CLI, "aws_rds/cli"
end
