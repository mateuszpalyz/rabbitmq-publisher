require 'test_helper'

class AckWorkerTest < ActiveSupport::TestCase

  def setup
    currency = Currency.create
    @message = {id: 1, uuid: currency.uuid}.to_json
    @worker = AckWorker.new
  end

  test 'should set ack for given currency to true' do
    @worker.work(@message)

    assert Currency.last.ack1
  end

  test 'should not set other ack-s for given currency to true' do
    @worker.work(@message)

    refute Currency.last.ack2
    refute Currency.last.ack3
  end

  test 'should return ack when succeeded' do
    assert_equal :ack, @worker.work(@message)
  end

  test 'should return reject when currency is not found' do
    assert_equal :reject, @worker.work({id: 1, uuid: 'aaaa'}.to_json)
  end
end
