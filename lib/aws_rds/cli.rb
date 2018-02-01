module AwsRds
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean
    class_option :profile, desc: "profile to use"

    desc "create NAME", "create database"
    long_desc Help.text(:create)
    option :db_name, desc: "database name"
    option :db_user, desc: "database user"
    option :db_password, desc: "database password"
    option :security_group_name, desc: "security group to create if not vpc_security_group_ids not set in profile"
    def create(name)
      Create.new(options.merge(name: name)).run
    end
  end
end
