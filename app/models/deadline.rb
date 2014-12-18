class Deadline < ActiveRecord::Base

	validates :nume, presence: true
    validates :descriere, presence: true
	validates :data_start, presence: true
    validates :data_end, presence: true
    validates :public_tinta, presence: true
    validate :data_start_is_before_data_end

    def data_start_is_before_data_end
    	if data_start > data_end
    		errors.add(:data_end, ": Data_end trebuie sa fie dupa data_start.")
    	end
    end

end
