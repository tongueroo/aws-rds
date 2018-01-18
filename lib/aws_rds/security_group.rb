module AwsRds
  class SecurityGroup
    include AwsServices

    # Returns Aws::EC2::Types::SecurityGroup
    def find_or_create(name)
      begin
        resp = ec2.describe_security_groups(group_names: [name])
      rescue Aws::EC2::Errors::InvalidGroupNotFound
        puts "Creating security group #{name}"
        result = ec2.create_security_group(group_name: name, description: name)
        resp = ec2.describe_security_groups(group_ids: [result.group_id])
      end

      resp.security_groups.first
    end

    def self.find_or_create(name)
      new.find_or_create(name)
    end
  end
end
