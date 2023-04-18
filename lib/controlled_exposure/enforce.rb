# frozen_string_literal: true

module ControlledExposure
  module Enforce
    extend ActiveSupport::Concern

    protected

    def view_assigns
      {}
    end
  end
end
