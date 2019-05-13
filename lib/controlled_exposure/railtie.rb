# frozen_string_literal: true

require 'controlled_exposure/expose'
require 'controlled_exposure/enforce'

module ControlledExposure
  class Railtie < ::Rails::Railtie
    initializer 'controller_exposer.include_expose' do
      ActiveSupport.on_load :action_controller do
        extend ControlledExposure::Expose
      end
    end
  end
end
