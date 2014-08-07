class AlegeriUserTema < ActiveRecord::Base
	belongs_to :user
    belongs_to :tema
end
