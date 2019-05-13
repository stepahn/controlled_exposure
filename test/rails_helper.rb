# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require 'rails'
require 'action_controller'
require 'controlled_exposure'

module ControlledExposureTestApp
  class Application < Rails::Application
    config.secret_key_base = 'test'
    config.eager_load = false
    config.logger = Logger.new(StringIO.new)

    routes.append do
      get '/test_enforce', to: 'controlled_exposure_test_app/enforce#test_enforce'
      get '/test_enforce_helper', to: 'controlled_exposure_test_app/enforce#test_enforce_helper'
      get '/test_expose', to: 'controlled_exposure_test_app/enforce#test_expose'
      get '/test_expose_ivar', to: 'controlled_exposure_test_app/enforce#test_expose_ivar'
      get '/test_expose_ivar', to: 'controlled_exposure_test_app/enforce#test_expose_ivar'
      get '/test_unenforced_expose', to: 'controlled_exposure_test_app/unenforced#test_expose'
    end
  end
end

ControlledExposureTestApp::Application.initialize!

module ControlledExposureTestApp
  class EnforceController < ActionController::Base
    def render_helper
      render inline: '<%= foo %>'
    end

    enforce_expose!
    expose :foo

    def test_enforce
      @bar = params[:txt]
      render inline: '<%= @bar %>'
    end

    def test_enforce_helper
      self.foo = params[:txt]
      render inline: '<%= @foo %>'
    end

    def test_expose
      self.foo = params[:txt]
      render_helper
    end

    def test_expose_ivar
      @foo = params[:txt]
      render_helper
    end
  end

  class UnenforcedController < ActionController::Base
    expose :foo

    def test_expose
      self.foo = params[:txt]
      render inline: '<%= foo %>'
    end
  end
end
