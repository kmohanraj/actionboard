class Item < ActiveRecord::Base
   validates :description, :quantity, :unit_cost, :presence => true
   validates :unit_cost, :numericality => { :greater_than_or_equal_to => 0 }
   validates :quantity, :numericality => { :greater_than => 0 }
   validates :discount, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100}
   validates :client_id, :presence => true, :unless => :nested
  attr_accessor :nested
  
  # has_many :invoice
  has_many :client

  
  def total_price
    self.unit_cost * self.quantity * ((100 - self.discount) / 100.0)
  rescue NoMethodError => method
    0
  end
  def total_amount
    if grn.saved_in_old_tax_mode?
      net_amount = gross_amount + tax_amount(gross_amount)
      net_amount - discount_amount(net_amount) 
    else
      net_amount = gross_amount - discount_amount(gross_amount)
      net_amount + tax_amount(net_amount)
    end  
  end
  def total_balance
      total -= total_price
  end
  
  def gross_amount
     total_price.to_f - tax.to_f
  end

  def balance_amount
    total_price * (balance * 0.01)
  end

  def price
    de = @item.total_price - tax
  end
  
  def tax_amount(amount)
    return amount * ( tax * 0.01)
  end
end
