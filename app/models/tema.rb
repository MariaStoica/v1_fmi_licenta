class Tema < ActiveRecord::Base
    belongs_to :domeniu
    
    validates :nume,  presence: true
    validates :domeniu_id,  presence: true
    
end
