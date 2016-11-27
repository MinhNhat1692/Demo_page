class CreateApikeys < ActiveRecord::Migration[5.0]
  def change
    create_table :apikeys do |t|
      t.text :appid
      t.text :soapi
      t.text :mapi
      t.text :adminapi

      t.timestamps
    end
  end
end
