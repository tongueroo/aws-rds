require "erb"

module AwsRds::TemplateHelper
  def config
    AwsRds.config
  end

  private
  def load_custom_helpers
    Dir.glob("#{AwsRds.root}/app/helpers/**/*_helper.rb").each do |path|
      filename = path.sub(%r{.*/},'').sub('.rb','')
      module_name = filename.classify

      require path
      self.class.send :include, module_name.constantize
    end

  end

  def erb_result(path)
    load_custom_helpers
    template = IO.read(path)

    # Allow a way to bypass the custom ERB error handling in case
    # the error is in the lambdagem code.
    if ENV['DEBUG']
      return ERB.new(template, nil, "-").result(binding)
    end

    begin
      ERB.new(template, nil, "-").result(binding)
    rescue Exception => e
      puts e

      # how to know where ERB stopped? - https://www.ruby-forum.com/topic/182051
      # syntax errors have the (erb):xxx info in e.message
      # undefined variables have (erb):xxx info in e.backtrac
      error_info = e.message.split("\n").grep(/\(erb\)/)[0]
      error_info ||= e.backtrace.grep(/\(erb\)/)[0]
      raise unless error_info # unable to find the (erb):xxx: error line
      line = error_info.split(':')[1].to_i
      puts "Error evaluating ERB template on line #{line.to_s.colorize(:red)} of: #{path.sub(/^\.\//, '')}"

      template_lines = template.split("\n")
      context = 5 # lines of context
      top, bottom = [line-context-1, 0].max, line+context-1
      spacing = template_lines.size.to_s.size
      template_lines[top..bottom].each_with_index do |line_content, index|
        line_number = top+index+1
        if line_number == line
          printf("%#{spacing}d %s\n".colorize(:red), line_number, line_content)
        else
          printf("%#{spacing}d %s\n", line_number, line_content)
        end
      end

      puts "\nIf the this error does not make sense and the error is not in the ERB template. Run the command again with DEBUG=1 to show the full lambdagem backtrace"
      exit 1 unless ENV['TEST']
    end
  end
end
