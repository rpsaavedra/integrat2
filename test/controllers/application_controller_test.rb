require 'test_helper'
require_relative 'simple_number'

class ApplicationControllerTest < ActionController::TestCase

  test 'suma' do
  	assert_equal(4, SimpleNumber.new(2).add(2) )
    assert_equal(6, SimpleNumber.new(2).multiply(3), "Has fallado")
  end
end