# encoding: utf-8

module Rubocop
  module Cop
    class CollectionMethods < Cop
      PREFERRED_METHODS = {
        collect: 'map',
        inject: 'reduce',
        detect: 'find',
        find_all: 'select'
      }

      def inspect(file, source, tokens, ast)
        on_node(:send, ast) do |node|
          receiver, method_name, *_args = *node

          # a simple(but flawed way) to reduce false positives
          next unless receiver

          if PREFERRED_METHODS[method_name]
            add_offence(
              :convention,
              node.src.line,
              "Prefer #{PREFERRED_METHODS[method_name]} over #{method_name}."
            )
          end
        end
      end
    end
  end
end
