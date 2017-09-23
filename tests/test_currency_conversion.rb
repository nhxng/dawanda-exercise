require_relative '../lib/currency_conversion.rb'
require 'test/unit'

class TestCurrencyConversion < Test::Unit::TestCase
  # exact values will be stored, so numbers need to be rounded to equal expected values
  def test_attributes
    fifty_eur = Money.new(50, 'EUR')
    assert_equal(50, fifty_eur.amount)
    assert_equal('EUR', fifty_eur.currency)
    assert_equal('50.00 EUR', fifty_eur.inspect)
  end

  def test_convert
    fifty_eur = Money.new(50, 'EUR')
    expect_converted_fifty_eur = Money.new(55.50, 'USD')
    converted_fifty_eur = fifty_eur.convert_to('USD')
    assert_equal(expect_converted_fifty_eur, Money.new(converted_fifty_eur.amount.round(2), converted_fifty_eur.currency))
  end

  def test_sum
    sum = Money.new(50, 'EUR') + Money.new(20, 'USD')
    assert_equal(Money.new(68.02, 'EUR'), Money.new(sum.amount.round(2), 'EUR'))
  end

  def test_substract
    sum = Money.new(50, 'EUR') - Money.new(20, 'USD')
    assert_equal(Money.new(31.98, 'EUR'), Money.new(sum.amount.round(2), 'EUR'))
  end

  def test_multiplication
    product = Money.new(20, 'USD') * 3
    assert_equal(Money.new(60, 'USD'), Money.new(product.amount, product.currency))
  end

  def test_division
    quotient = Money.new(50, 'EUR') / 2
    assert_equal(Money.new(25, 'EUR'), Money.new(quotient.amount, quotient.currency))
  end
end
