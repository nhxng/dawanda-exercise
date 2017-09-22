CONVERSION_RATES = {'EUR' => {
   'USD'     => 1.11,
   'Bitcoin' => 0.0047 }
}

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
      'USD'     => eur_in_usd,
      'Bitcoin' => eur_in_bc
      }
    when 'USD'
      return {
      'USD'     => 1/eur_in_usd,
      'Bitcoin' => 1/eur_in_bc
      }
    else 'currency not available'
    end
  end

  def inspect
    "#{sprintf('%.2f', amount)} #{currency}"
    # "#{amount} #{currency}"
  end

  def convert_to(currency)
    #converted_amount =  self.amount * CONVERSION_RATES['EUR'][currency]
    #converted_money = Money.new(converted_amount, currency)
    #return converted_money
    #p Money.conversion_rates(self.currency)[currency]
    converted_amount =  self.amount * Money.conversion_rates(self.currency)[currency]
    converted_money = Money.new(converted_amount, currency)
    return converted_money
  end

  include Comparable

  def <=>(other)
    amount <=> other.amount
  end

  def +(other)
    first_val = self
    second_val = other
    first_val = self.convert_to(self.currency) if self.currency != 'EUR'
    second_val = other.convert_to(other.currency) if other.currency != 'EUR'
    return Money.new(first_val.amount.public_send(:+, second_val.amount), 'EUR')
  end

  def -(other)
    first_val = self
    second_val = other
    first_val = self.convert_to(self.currency) if self.currency != 'EUR'
    second_val = other.convert_to(other.currency) if other.currency != 'EUR'
    return Money.new(first_val.amount.public_send(:-, second_val.amount), 'EUR')
  end

end

fifty_eur = Money.new(50, 'EUR')
twenty_dollars = Money.new(20, 'USD')
p fifty_eur.convert_to('USD')
p fifty_eur + twenty_dollars
p fifty_eur - twenty_dollars
