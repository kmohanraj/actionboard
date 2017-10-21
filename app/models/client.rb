class Client < ApplicationRecord
   validates :name, :presence => true
   validates :email, :presence => true
   validates :company,:presence => true
  # belongs_to :company
   has_many :items
#    belongs_to :items
end
