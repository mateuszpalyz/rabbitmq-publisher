require 'test_helper'

class FetcherTest < ActiveSupport::TestCase

  def setup
    stub_request(:get, "https://openexchangerates.org/api/latest.json?app_id=" + ENV['RATES_SECRET']).to_return response
  end

  test "should fetch currencies when db is empty" do
    Fetcher.fetch_currencies
    assert 1, Currency.count
  end

  test "should fetch currencies when last record is older than 1 hour" do
    Timecop.freeze(Time.now)
    Fetcher.fetch_currencies
    Timecop.freeze(Time.now + 61.minutes)

    assert_difference 'Currency.count', 1 do
      Fetcher.fetch_currencies
    end
    Timecop.return
  end

  test "shouldn't fetch currencies if last record isn't older than 1 hour" do
    Fetcher.fetch_currencies

    assert_no_difference 'Currency.count' do
      Fetcher.fetch_currencies
    end
  end

  test "should return currencies rates hash" do
    rates = Fetcher.fetch_currencies
    assert_kind_of Hash, rates
  end
end
