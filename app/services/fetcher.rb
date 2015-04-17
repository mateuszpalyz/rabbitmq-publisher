class Fetcher

  def self.fetch_currencies
    last_currency = Currency.last
    !last_currency || last_currency.created_at < 1.hour.ago ? update_currencies : last_currency
  end

  private

  def self.update_currencies
    Currency.create(rates: fetched_rates)
  end

  def self.fetched_rates
    JSON.parse(response.body)['rates']
  end

  def self.response
    Net::HTTP.get_response(URI.parse(url))
  end

  def self.url
    "https://openexchangerates.org/api/latest.json?app_id=" + ENV['RATES_SECRET']
  end
end
