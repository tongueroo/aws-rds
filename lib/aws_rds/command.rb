require "thor"

module AwsRds
  class Command < Thor
    class << self
      def dispatch(m, args, options, config)
        # Allow calling for help via:
        #   aws_rds command help
        #   aws_rds command -h
        #   aws_rds command --help
        #   aws_rds command -D
        #
        # as well thor's normal way:
        #
        #   aws_rds help command
        help_flags = Thor::HELP_MAPPINGS + ["help"]
        if args.length > 1 && !(args & help_flags).empty?
          args -= help_flags
          args.insert(-2, "help")
        end
        super
      end
    end
  end
end
