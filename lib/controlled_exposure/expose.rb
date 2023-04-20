# frozen_string_literal: true

module ControlledExposure
  module Expose
    extend ActiveSupport::Concern

    private

    class_methods do
      def expose(attr)
        ActiveSupport::Deprecation.warn('.expose is deprecated. Use .attr_expose instead.')
        attr_expose(attr)
      end

      def enforce_expose!
        include ControlledExposure::Enforce
      end

      def def_expose(method, &block)
        define_method(method, &block)

        protected(method)

        helper_method(method)
      end

      def attr_expose(*args)
        args.each do |attr|
          attr_accessor(attr)

          protected(attr)

          helper_method(attr)
        end
      end
    end
  end
end
