require 'aws-sdk-rds'
require 'aws-sdk-ec2'

module AwsRds::AwsServices
  def rds
    @rds ||= Aws::RDS::Client.new
  end

  def ec2
    @ec2 ||= Aws::EC2::Client.new
  end
end
