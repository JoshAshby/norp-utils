require 'norp/formatters/base'

module Norp
  module Utils
    module Formatters

      class Bare < Norp::Formatters::Base
        def get_output
          messages = []

          @files.each do |file|
            next unless file.messages.any?

            messages << "File: #{file.path}"

            file.messages.each do |msg|
              body = msg.body.split("\n").map{ |l| "    #{ l }" }.join "\n"

              messages << "  #{ msg.level }: Line ##{ msg.line }\n#{ body }"
            end

            messages << ""
          end

          messages.join "\n"
        end
      end

    end
  end
end
