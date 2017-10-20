class Invoice < ActiveRecord::Base
  
  # validates :client_id, :presence => true
  # validates :status, :inclusion => { :in => ['pending', 'Paid' ] }
  
  #validate :at_least_one_item
    attr_accessor :nested


  belongs_to :client #this is working for client name in invoices index page
  belongs_to :items
  has_many :items, :dependent => :destroy
  accepts_nested_attributes_for :items, :allow_destroy => true
  
  
  def at_least_one_item
    self.errors.add(:items, "Invoice should have at least one item.") if self.items.empty?
  end
  def total_price
    self.unit_cost * self.quantity * ((100 - self.discount) / 100.0)
  rescue NoMethodError => method
    0
  end
  def total  
    @total = 0
    self.items.each do |item|
      @total += item.total_price
    end
    
    @total
  end

  
end
