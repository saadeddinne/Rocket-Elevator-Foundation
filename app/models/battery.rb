class Battery < ApplicationRecord
  belongs_to :building
  has_many :columns, :dependent => :delete_all

  def type_status
    "#{battery_type}  #{battery_status} "
  end
end