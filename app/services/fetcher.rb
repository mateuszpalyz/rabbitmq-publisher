class Fetcher

  def fetch_currencies
    update_currencies if !Currency.any? || Currency.last.created_at < 1.hour.ago
    Currency.last.rates
  end

  private

  def update_currencies
    Currency.create(rates: fetched_rates)
  end

  def fetched_rates
    JSON.parse(response.body)['rates']
  end

  def response
    Net::HTTP.get_response(URI.parse(url))
  end

  def url
    "https://openexchangerates.org/api/latest.json?app_id=" + ENV['RATES_SECRET']
  end
end
