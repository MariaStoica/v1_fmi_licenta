class DropLicentaSalvatas < ActiveRecord::Migration
  def change
  	drop_table :licenta_salvatas
  end
end
