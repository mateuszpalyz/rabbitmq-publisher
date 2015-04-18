class AckWorker
  include Sneakers::Worker
  from_queue 'currencies.acknowledgements', env: nil

  def work(message)
    message = JSON.parse(message)
    currency = currency_with_uuid(message['uuid'])

    if currency
      currency.update_attribute("ack#{message['id']}", true)
      ack!
    else
      reject!
    end
  end

  private

  def currency_with_uuid(uuid)
    Currency.find_by(uuid: uuid)
  end
end
