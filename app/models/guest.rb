class Guest < ActiveRecord::Base
	belongs_to :event

	validates	:first_name, presence: true, length: {maximum: 80}
	validates	:last_name, presence: true, length: {maximum: 80}
end
