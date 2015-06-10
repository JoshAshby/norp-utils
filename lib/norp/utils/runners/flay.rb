require 'norp/runners/base'

require 'flay'

module Norp
  module Utils
    module Runners

      class Flay < Norp::Runners::Base
        def run!
          return unless files

          file_hash = {}
          files.each do |file|
            file_hash[file.path] = file
          end

          flay = ::Flay.new

          flay.process *files.map{ |file| file.path }

          results = flay.analyze

          results.each do |item|
            if item.identical?
              match_type, level = "Identical", :warning
            else
              match_type, level = "Similar", :info
            end

            msg = [ "#{ match_type } code found" ]

            item.locations.each do |location|
              msg << "#{ location.file }:#{ location.line } #{ 'fuzzy' if location.fuzzy? }"
            end

            msg = msg.join "\n"

            item.locations.each do |location|
              next unless file_hash.has_key? location.file

              file_hash[location.file].add_message msg, level: level, line: location.line
            end
          end
        end
      end

    end
  end
end
