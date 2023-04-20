# frozen_string_literal: true

require 'test_helper'

class DeprecateEposeTest < ActiveSupport::TestCase
  def test_deprecation
    assert_deprecated do
      Class.new(ControlledExposureTestApp::ApplicationController) do
        expose(:foo)
      end
    end
  end
end
