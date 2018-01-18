module AwsRds
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "create NAME", "create database"
    long_desc Help.text(:create)
    option :profile, desc: "profile to use"
    option :db_name, desc: "database name"
    option :db_user, desc: "database user"
    option :db_password, desc: "database password"
    def create(name)
      Create.new(options.merge(name: name)).run
    end
  end
end
