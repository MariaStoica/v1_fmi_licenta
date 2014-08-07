class Capitol < ActiveRecord::Base
	belongs_to :licenta
    has_many :comentariu_capitols
    has_many :todos
    has_many :fisiers
    
    validates :nume, presence: true
end
