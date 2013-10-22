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
    tax += (item.price * item.calc_tax_rate) / 100
  end

  def total(item)
    item.price + item.calc_tax
  end

  def receipt(*items)
    applied_tax = items.inject(0) { |sum,item| sum += item.calc_tax }
    receipt_total = items.inject(0) { |sum,item| sum =+ item.total }

    receipt_printout = String.new
    receipt_printout << items.each { |item| "1 #{item.name}: #{item.price} " } << "Sales Tax: #{applied_tax} Total: #{receipt_total}"
  end
end