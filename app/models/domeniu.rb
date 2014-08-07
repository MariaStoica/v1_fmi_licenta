class Domeniu < ActiveRecord::Base
    belongs_to :user
    has_many :temas
    
    def self.search(search)
        search_condition = "%" + search + "%"
        find(:all, :conditions => ['nume LIKE ? OR descriere LIKE ?', search_condition, search_condition])
        #SELECT * FROM foo WHERE bar LIKE "%query%" LIMIT 10;
    end

    validates :nume,  presence: true

end
