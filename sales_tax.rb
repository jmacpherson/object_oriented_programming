# Classes

class CashRegister
  @@sales_tax = 10
  @@import_duty = 5

  def calc_tax_rate(item)
    tax_rate = 0
    tax_rate += @@import_duty if item.imported
    tax_rate += @@sales_tax unless (item.is_a? Book) || (item.is_a? Food) || (item.is_a? Medicine)
  end

  def calc_tax(item)
    tax = 0
    tax += (((item.price * item.number.to_f) * calc_tax_rate(item).to_f) / 100)

    #round to nearest 0.05
    if tax % 0.05 != 0
      tax += 0.05 - (tax % 0.05)
    end
    
    tax
  end

  def total(item)
    item.price + calc_tax(item)
  end

  def receipt(*items)
    #calculate tax on each item
    items_tax = items.collect { |item| calc_tax(item) }

    #calculate total tax for receipt
    applied_tax = 0
    items_tax.each { |tax| applied_tax += tax }
    # applied_tax = sprintf("%.2f", applied_tax)

    #calculate total price for receipt
    receipt_total = 0
    items.each { |item| receipt_total += total(item) }

    #return receipt printout
    receipt_printout = String.new
    items.each { |item| receipt_printout << "#{item.number} #{item.name}: #{item.price} " }
    receipt_printout << "Sales Tax: #{sprintf("%.2f",applied_tax)} Total: #{sprintf("%.2f",receipt_total)}"
  end
end

class Product
  attr_reader :name, :price, :number, :imported

  def initialize (name, price, imported=false, number=1)
    @name = name
    @price = price
    @number = number
    @imported = imported
  end
end

class Book < Product
end

class Food < Product
end

class Medicine < Product
end

# Tests

register = CashRegister.new

book = Book.new("book",12.49)
cd = Product.new("music CD",14.99)
choc_bar = Food.new("chocolate bar",0.85)

puts register.calc_tax(cd)

puts register.receipt(book, cd, choc_bar)