# frozen_string_literal: true

require 'test_helper'

class ControlledExposureTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ControlledExposure::VERSION
  end
end
