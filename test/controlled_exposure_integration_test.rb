# frozen_string_literal: true

require 'test_helper'

class ControlledExposureIntegrationTest < ActionDispatch::IntegrationTest
  def assert_response_body(path, expected, text: nil, params: { txt: text })
    get path, params: params
    assert_response :success
    assert_equal(expected, response.parsed_body)
  end

  def test_attr_expose
    assert_response_body('/test_attr_expose', 'TEST_BAR|TEST_BAZ', params: { bar: 'TEST_BAR', baz: 'TEST_BAZ' })
  end

  def test_def_expose
    assert_response_body('/test_def_expose', '|TEST_FOO|TEST_BAR|', params: { foo: 'TEST_FOO', bar: 'TEST_BAR' })
  end

  def test_enforce
    assert_response_body('/test_enforce', '', text: 'TEST_STRING')
  end

  def test_enforce_helper
    assert_response_body('/test_enforce_helper', '', text: 'TEST_STRING')
  end

  def test_expose
    assert_response_body('/test_expose', 'TEST_STRING', text: 'TEST_STRING')
  end

  def test_unenforced_attr_expose
    assert_response_body('/test_unenforced_attr_expose', 'TEST_STRING', text: 'TEST_STRING')
  end

  def test_unenforced_ivar
    assert_response_body('/test_unenforced_ivar', 'TEST_STRING', text: 'TEST_STRING')
  end
end
