require 'aws-sdk-rds'

module AwsRds::AwsServices
  def rds
    @rds ||= Aws::RDS::Client.new
  end
end
