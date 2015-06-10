require 'norp/runners/base'

require 'reek'

module Norp
  module Utils
    module Runners

      class Reek < Norp::Runners::Base
        def run!
          return unless files

          file_hash = {}
          files.each do |file|
            file_hash[file.path] = file
          end

          reek = ::Reek::Core::Examiner.new files.map{ |file| file.path }

          reek.smells.each do |smell|
            next unless file_hash.has_key? smell.source

            smell.lines.each do |line|
              file_hash[smell.source].add_message smell.message, level: :info, line: line
            end
          end
        end
      end

    end
  end
end
