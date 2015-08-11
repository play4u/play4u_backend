class PersonDetail < ActiveRecord::Base
  belongs_to :person, polymorphic: true

  def to_s
      to_json
  end
end
