class DJ < ActiveRecord::Base
  has_one :location, as: :person
end