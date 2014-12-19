class Fisier < ActiveRecord::Base
    belongs_to :capitol
    has_many :comentariu_fisiers

validates :name, presence: true
validates :capitol_id, presence: true
# validates :path, presence: true


    def self.save(fisier,upload)
        name =  fisier[:name]
        directory = "public/data/"
        # create the file path
        path = File.join(directory, name)
        #fisier.path = path
        fisier.update_attributes(path: "public/data/" + name)
        # write the file
        File.open(path, "wb") { |f| f.write(upload.tempfile.read) }
    end

end
