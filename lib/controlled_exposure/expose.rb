# frozen_string_literal: true

module ControlledExposure
  module Expose
    private

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
