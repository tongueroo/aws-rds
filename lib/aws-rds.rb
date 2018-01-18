$:.unshift(File.expand_path("../", __FILE__))
require "aws_rds/version"

module AwsRds
  autoload :Help, "aws_rds/help"
  autoload :Command, "aws_rds/command"
  autoload :CLI, "aws_rds/cli"
  autoload :AwsServices, "aws_rds/aws_services"
  autoload :Create, "aws_rds/create"
end
