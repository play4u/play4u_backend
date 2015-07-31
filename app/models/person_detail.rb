class PersonDetail < ActiveRecord::Base
  belongs_to :person, polymorphic: true
end