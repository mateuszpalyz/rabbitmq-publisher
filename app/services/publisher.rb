class Publisher

  def self.publish
    x = channel.fanout('currencies.fanout')
    x.publish(self.message)
  end

  private

  def self.channel
    @channel ||= connection.create_channel
  end

  def self.connection
    @connection ||= Bunny.new.tap { |c| c.start }
  end

  def self.message
    currencies.to_json
  end

  def self.currencies
    Fetcher.fetch_currencies.slice(:uuid, :rates)
  end
end
