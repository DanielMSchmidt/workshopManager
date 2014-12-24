class Subscriber < ActiveRecord::Base
  has_many :subscribables, through: :assignment
end
