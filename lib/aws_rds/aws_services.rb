require 'aws-sdk-rds'

module AwsRds::AwsServices
  def rds
    @rds ||= Aws::Rds::Client.new
  end
end
