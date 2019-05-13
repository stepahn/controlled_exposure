# frozen_string_literal: true

require 'test_helper'

class ControlledExposureIntegrationTest < ActionDispatch::IntegrationTest
  def assert_response_body(path, text, expected)
    get path, params: { txt: text }
    assert_response :success
    assert_equal(expected, response.parsed_body)
  end

  def test_enforce
    assert_response_body('/test_enforce', 'TEST_STRING', '')
  end

  def test_enforce_helper
    assert_response_body('/test_enforce_helper', 'TEST_STRING', '')
  end

  def test_expose
    assert_response_body('/test_expose', 'TEST_STRING', 'TEST_STRING')
  end

  def test_expose_ivar
    assert_response_body('/test_expose_ivar', 'TEST_STRING', 'TEST_STRING')
  end
end
