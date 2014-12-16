class Deadline < ActiveRecord::Base

	validates :nume, presence: true
    validates :descriere, presence: true
	validates :numar, presence: true
	validates :data_start, presence: true
    validates :data_end, presence: true

end
