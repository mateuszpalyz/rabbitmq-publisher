class Currency < ActiveRecord::Base
  before_create :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.hex(10)
  end
end
