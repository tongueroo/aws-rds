require "byebug"

module AwsRds
  class SecurityGroup
    include AwsServices

    # Returns Aws::EC2::Types::SecurityGroup
    def find_or_create(name)
      resp = ec2.describe_security_groups(
        filters: [
          {name: 'vpc-id', values: [AwsRds.config["vpc_id"]]},
          {name: 'group-name', values: [name]}]
        )
      sg = resp.security_groups.first
      return sg if sg

      puts "Creating security group #{name}"
      result = ec2.create_security_group(
        group_name: name,
        description: name,
        vpc_id: AwsRds.config["vpc_id"],
      )
      ec2.create_tags(
        resources: [result.group_id],
        tags: [{ key: "Name", value: name }],
      )
      resp = ec2.describe_security_groups(group_ids: [result.group_id])
      resp.security_groups.first
    end

    def self.find_or_create(name)
      new.find_or_create(name)
    end
  end
end
