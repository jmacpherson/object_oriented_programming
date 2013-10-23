# Classes

class CashRegister
  @@sales_tax = 10
  @@import_duty = 5

  def calc_tax_rate(item)
    tax_rate = 0
    tax_rate += @@import_duty if item.imported
    tax_rate += @@sales_tax unless (item.is_a? Book) || (item.is_a? Food) || (item.is_a? Medicine)
    
    return tax_rate
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
    items.each { |item| receipt_printout << "#{item.number} #{item.name}: #{sprintf("%.2f", total(item))} " }
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

# Test 1

register = CashRegister.new

book = Book.new("book",12.49)
cd = Product.new("music CD",14.99)
choc_bar = Food.new("chocolate bar",0.85)

puts register.receipt(book, cd, choc_bar)

# Test 2

imp_choc = Food.new("imported box of chocolates", 10.00, true)
imp_perfume = Product.new("imported bottle of perfume", 47.50, true)

puts register.receipt(imp_choc, imp_perfume)

# Test 3

imp_perfume2 = Product.new("imported bottle of perfume", 27.99, true)
perfume = Product.new("bottle of perfume", 18.99)
pills = Medicine.new("packet of headache pills", 9.75)
imp_choc2 = Food.new("imported box of chocolates", 11.25, true)

# puts "-------------"
# puts register.calc_tax_rate(imp_perfume2)
# puts register.calc_tax(imp_perfume2)
# puts "-------------"
# puts register.calc_tax_rate(imp_choc2)
# puts register.calc_tax(imp_choc2)

puts register.receipt(imp_perfume2, perfume, pills, imp_choc2)