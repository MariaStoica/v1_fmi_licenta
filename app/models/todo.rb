class Todo < ActiveRecord::Base
    belongs_to :capitol
    
    validates :continut, presence: true
    validates :capitol_id, presence: true
end
