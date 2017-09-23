class Money
  # define variables, default values and access
  attr_accessor :amount, :currency
  def initialize(amount, currency = "EUR")
    @amount = amount
    @currency = currency
  end

  # define conversion rates for base currency
  # instead of hard coding rates another gem or parsing of websites can be used to have dynamically changing rates
  def self.conversion_rates(base_currency)
    eur_in_usd = 1.11
    eur_in_bc = 0.0047
    case base_currency
    when 'EUR'
      return {
      'EUR'     => 1,
      'USD'     => eur_in_usd,
      'Bitcoin' => eur_in_bc
      }
    when 'USD'
      return {
      'USD'     => 1,
      'EUR'     => 1/eur_in_usd,
      'Bitcoin' => 1/eur_in_bc
      }
    else 'currency not available'
    end
  end

  # save exact amount but display with only two decimals
  def inspect
    return "#{sprintf('%.2f', amount)} #{currency}"
  end

  def convert_to(currency)
    converted_amount =  self.amount * Money.conversion_rates(self.currency)[currency]
    converted_money = Money.new(converted_amount, currency)
    return converted_money
  end

  include Comparable

  def <=>(other)
    first_val = self.convert_to('EUR')
    second_val = other.convert_to('EUR')
    first_val.amount <=> second_val.amount
  end

  [:+, :-].each do |op|
    define_method(op) do |other|
      first_val = self.convert_to('EUR')
      second_val = other.convert_to('EUR')
      return Money.new(first_val.amount.public_send(op, second_val.amount), 'EUR')
    end
  end

  [:*, :/].each do |op|
    define_method(op) do |value|
      return Money.new(self.amount.public_send(op, value), self.currency)
    end
  end

  # code covers all basic functions, more considerations about specific cases would be next step e.g.
  # - not passing amount of money
  # - passing negative amount of money
  # - more currencies available
  # - division by zero
  # - substract bigger values -> negative amount or always 0?
  # - raising individual error messsages
  # etc.
end


