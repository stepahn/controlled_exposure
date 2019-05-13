# frozen_string_literal: true

require 'controlled_exposure/version'

module ControlledExposure
  require 'controlled_exposure/railtie' if defined?(Rails)
end
