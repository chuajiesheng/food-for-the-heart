class MealAvailability < ApplicationRecord
  before_save :default_value

  def default_value
    self.chicken ||= 0
    self.mutton ||= 0
    self.beef ||= 0
    self.fish ||= 0
    self.prawn ||= 0
    self.squid ||= 0
  end

  def total
    chicken + mutton + beef + fish + prawn + squid
  end
end
