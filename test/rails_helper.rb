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
      get '/test_attr_expose', to: 'controlled_exposure_test_app/enforce#test_attr_expose'
      get '/test_def_expose', to: 'controlled_exposure_test_app/enforce#test_def_expose'
      get '/test_enforce', to: 'controlled_exposure_test_app/enforce#test_enforce'
      get '/test_enforce_helper', to: 'controlled_exposure_test_app/enforce#test_enforce_helper'
      get '/test_expose', to: 'controlled_exposure_test_app/enforce#test_expose'
      get '/test_expose_ivar', to: 'controlled_exposure_test_app/enforce#test_expose_ivar'
      get '/test_expose_ivar', to: 'controlled_exposure_test_app/enforce#test_expose_ivar'
      get '/test_unenforced_attr_expose', to: 'controlled_exposure_test_app/unenforced#test_attr_expose'
      get '/test_unenforced_ivar', to: 'controlled_exposure_test_app/unenforced#test_unenforced_ivar'
    end
  end
end

ControlledExposureTestApp::Application.initialize!

module ControlledExposureTestApp
  class ApplicationController < ActionController::Base
    def r(template)
      render inline: template
    end
  end

  class EnforceController < ApplicationController
    enforce_expose!
    expose :foo
    attr_expose :bar, :baz

    def_expose :foobar do
      "|#{params[:foo]}|#{params[:bar]}|"
    end

    def test_attr_expose
      self.bar = params[:bar]
      self.baz = params[:baz]

      r '<%= bar %>|<%= baz %>'
    end

    def test_def_expose
      r '<%= foobar %>'
    end

    def test_enforce
      @bar = params[:txt]
      r '<%= @bar %>'
    end

    def test_enforce_helper
      self.foo = params[:txt]
      r '<%= @foo %>'
    end

    def test_expose
      self.foo = params[:txt]
      r '<%= foo %>'
    end

    def test_expose_ivar
      @foo = params[:txt]
      r '<%= foo %>'
    end
  end

  class UnenforcedController < ApplicationController
    attr_expose :foo

    def test_attr_expose
      self.foo = params[:txt]
      r '<%= foo %>'
    end

    def test_unenforced_ivar
      @foo = params[:txt]
      r '<%= @foo %>'
    end
  end
end
