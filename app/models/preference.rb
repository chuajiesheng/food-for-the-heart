class Preference < ApplicationRecord
  belongs_to :user

  def to_array
    preferences = []

    preferences << 'chicken' if self.chicken?
    preferences << 'mutton' if self.mutton?
    preferences << 'beef' if self.beef?
    preferences << 'fish' if self.fish?
    preferences << 'prawn' if self.prawn?
    preferences << 'squid' if self.squid?

    preferences
  end
end
