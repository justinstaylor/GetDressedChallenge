# frozen_string_literal: false

require 'test/unit'
require_relative './get_dressed'

# get_dressed_test.rb
class GetDressedTest < Test::Unit::TestCase
  def test_dress
    assert_equal nil, GetDressed.int_to_str_arr([2, 5, 1]), 'Passed'
  end

  def test_file
    assert_equal nil, GetDressed.file_to_arr, 'Passed'
  end
end
