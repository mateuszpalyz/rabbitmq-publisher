require 'test_helper'

class PublisherTest < ActiveSupport::TestCase

  test 'publisher returs bunny exchange' do
    Fetcher.expects(:fetch_currencies).returns(Currency.new(uuid: 'abc', rates: []))
    assert_kind_of Bunny::Exchange, Publisher.publish
  end
end
