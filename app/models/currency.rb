class Currency < ActiveRecord::Base
  before_save :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.hex(10)
  end
end
