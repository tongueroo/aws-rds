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

      puts "Creating security group #{name}".colorize(:green)
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
      puts "ERROR: a vpc_id was not specified.".colorize(:red)
      puts <<-EOL
No vpc_id was specified in your profile. Also, a fallback vpc_id was set.

Please add a vpc_id in your profile file or add a fallback vpc_id to your config/#{AwsRds.env}.yml.

To specify a fallback vpc_id setting. Example config/#{AwsRds.env}.yml:
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
