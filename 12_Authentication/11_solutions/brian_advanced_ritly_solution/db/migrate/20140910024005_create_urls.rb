class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :hash_code
      t.string :link

      t.timestamps
    end
  end
end
