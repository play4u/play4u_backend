class PersonDetail < ActiveRecord::Base
  belongs_to :person, polymorphic: true

  def to_h
    as_json
  end
  
  def to_json
    as_json.merge({person: person}).to_json
  end

  def to_s
      to_json
  end
end
