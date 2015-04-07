require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test "should generate uuid before object is saved" do
    currency = Currency.new
    currency.save

    assert_equal 20, currency.uuid.length
  end
end
