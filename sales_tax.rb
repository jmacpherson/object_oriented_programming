class CashRegister
  @@sales_tax = 10
  @@import_duty = 5

  def calc_tax_rate(item)
    tax_rate = 0
    tax_rate += @@import_duty if item.imported
    tax_rate += @@sales_tax unless (item.class == Book) || (item.class == Food) || (item.class == Medicine)
  end

  def calc_tax(item)
    tax = 0
    tax += ((item.price * item.number) * calc_tax_rate(item)) / 100
  end

  def total(item)
    item.price + calc_tax(item)
  end

  def receipt(*items)
    applied_tax = items.inject(0) { |sum,item| sum += calc_tax(item) }
    receipt_total = items.inject(0) { |sum,item| sum =+ total(item) }

    receipt_printout = String.new
    receipt_printout << items.each { |item| "#{item.number} #{item.name}: #{item.price} " } << "Sales Tax: #{applied_tax} Total: #{receipt_total}"
  end
end

class Product
  attr_reader :price, :number, :imported

  def initialize (price, number=1, imported=false)
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