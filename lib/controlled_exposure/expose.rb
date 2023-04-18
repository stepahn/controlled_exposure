# frozen_string_literal: true

module ControlledExposure
  module Expose
    extend ActiveSupport::Concern

    private

    class_methods do
      def expose(attr)
        attr_accessor attr
        helper_method attr
        protected attr
      end

      def enforce_expose!
        include ControlledExposure::Enforce
      end

    def expose(attr)
      attr_accessor attr
      helper_method attr
      protected attr
    end
  end
end
