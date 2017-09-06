class Client < ApplicationRecord
  before_save :valid_uniqueness
  validates :name,
    presence: true,
    length: { is: 3 },
    format: { without: /[^a-z]/ }

  # Check if record exists in the Client table
  def valid_uniqueness
    throw :abort if exists? == true
  end

  # Check if record exists in the Client table
  def exists?
    if Client.exists?(name: self.name)
      true
    else
      false
    end
  end

  # Generate new name if entry already exists
  def generate_random_name
    ('a'..'z').to_a.shuffle[0,3].join
  end
end
