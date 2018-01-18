module AwsRds
  class CLI < Command
    class_option :verbose, type: :boolean
    class_option :noop, type: :boolean

    desc "create NAME", "create database"
    long_desc Help.text(:create)
    option :profile, desc: "profile to use"
    option :password, desc: "password"
    def create(name)
      Create.new(options.merge(name: name)).run
    end
  end
end
