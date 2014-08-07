class Licenta < ActiveRecord::Base
    has_many :capitols
    has_many :comentariu_licentas
    
    validates :user_id, uniqueness: true
end
