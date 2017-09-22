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

  # def two_decimal
  #   return sprintf('%.2f', "#{self.amount}")
  # end

  def inspect
    "#{sprintf('%.2f', amount)} #{currency}"
    # "#{amount} #{currency}"
  end

  def convert_to(currency)
    converted_amount =  self.amount * CONVERSION_RATES['EUR'][currency]
    converted_money = Money.new(converted_amount, currency)
    return converted_money
  end
  include Comparable

  def <=>(other)
    amount <=> other.amount
  end

  def +(other)
    # [:+, :-].each do |op|
    #     other = other.convert_to('EUR')
    #     self.class.new(amount.public_send(op, other.amount), currency)
    # end
    puts self.inspect
    puts other.inspect
    first_val = self
    second_val = other
    first_val = self.convert_to(self.currency) if self.currency != 'EUR'
    p first_val
    second_val = other.convert_to(other.currency) if other.currency != 'EUR'
    p second_val
    p first_val.amount.public_send(:+, second_val.amount)
    return Money.new(first_val.amount.public_send(:+, second_val.amount), 'EUR')

    # other = other.convert_to('EUR')
    # self.class.new(amount.public_send(op, other.amount), currency)
  end

end

# Money.conversion_rates('EUR', {
#   'USD'     => 1.11,
#   'Bitcoin' => 0.0047
# })
fifty_eur = Money.new(50, 'EUR')
twenty_dollars = Money.new(20, 'USD')
fifty_eur < twenty_dollars
# p fifty_eur.convert_to('USD')
p fifty_eur + twenty_dollars

# base currency = eur
