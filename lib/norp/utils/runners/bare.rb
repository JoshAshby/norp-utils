require 'norp/wrappers/message'

module Norp
  module Utils
    module Runners

      class Bare < Norp::Runners::Base
        def run!
          files.each do |file|
            file.add_message "Test msg", level: Norp::Wrappers::Message::LEVELS.sample, source: :bare
          end
        end
      end

    end
  end
end
