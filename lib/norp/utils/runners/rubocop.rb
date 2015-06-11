require 'norp/runners/base'

require 'rubocop'

module Norp
  module Utils
    module Runners

      class Rubocop < Norp::Runners::Base
        def run!
          return unless files

        end
      end

    end
  end
end
