class LicentaSalvata < ActiveRecord::Base
    has_many :capitols
    has_many :comentariu_licentas
end
