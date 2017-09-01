class Client < ApplicationRecord
	validates :name,
		presence: true,
		uniqueness: true,
		length: { is: 3 },
		format: { without: /[^a-z]/ }

end
