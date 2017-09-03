class Client < ApplicationRecord
  before_save :valid_uniqueness
  validates :name,
    presence: true,
    length: { is: 3 },
    format: { without: /[^a-z]/ }

    # Check if record exists in the Client table
    def valid_uniqueness
      throw :abort if is_unique? == false
    end

    # Check if record exists in the Client table
    def is_unique?
      if Client.exists?(name: self.name)
        false
      else
        true
      end
    end

    # Generate new name if entry already exists
    def generate_random_name
      ('a'..'z').to_a.shuffle[0,3].join
    end
end
