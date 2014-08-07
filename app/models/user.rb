class User < ActiveRecord::Base

	validates :nume,  presence: true, length: { maximum: 50 }
    validates :prenume,  presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true

	scope :profesori_eligibili, where(rol: "Profesor").where(este_eligibil_licenta: true)
    

end
