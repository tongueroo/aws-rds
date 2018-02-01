module AwsRds
  class SecurityGroup
    include AwsServices

    # Returns Aws::EC2::Types::SecurityGroup
    def find_or_create(name)
      resp = ec2.describe_security_groups(
        filters: [
          {name: 'vpc-id', values: [fallback_vpc_id]},
          {name: 'group-name', values: [name]}]
        )
      sg = resp.security_groups.first
      return sg if sg

      puts "Creating security group #{name}"
      result = ec2.create_security_group(
        group_name: name,
        description: name,
        vpc_id: fallback_vpc_id,
      )
      # TODO: add waiter
      # ec2.create_tags(
      #   resources: [result.group_id],
      #   tags: [{ key: "Name", value: name }],
      # )
      resp = ec2.describe_security_groups(group_ids: [result.group_id])
      resp.security_groups.first
    end

    def fallback_vpc_id
      AwsRds.config["fallback"]["vpc_id"]
    rescue NoMethodError => e
      puts e.message
      puts <<-EOL
Unable to load a fallback vpc id from your config/#{AwsRds.env}.yml.
Please specify a fallback vpc_id setting.

Example config/#{AwsRds.env}.yml:
---
fallback:
  vpc_id: vpc-123
EOL
      exit 1
    end

    def self.find_or_create(name)
      new.find_or_create(name)
    end
  end
end
