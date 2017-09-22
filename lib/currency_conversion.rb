class Money
  attr_accessor :amount, :currency
  def initialize(amount = 0, currency = "EUR")
    @amount = amount
    @currency = currency
  end

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

end

fifty_eur = Money.new(50, 'EUR')
twenty_dollars = Money.new(20, 'USD')
fifty_eur.convert_to('USD')
fifty_eur - twenty_dollars
twenty_dollars * 3
fifty_eur / 2
p twenty_dollars < fifty_eur
p twenty_dollars == Money.new(20, 'EUR')


