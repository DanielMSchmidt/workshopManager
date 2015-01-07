class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :subscribable_id
      t.string :subscribable_type
      t.text :content

      t.timestamps
    end
  end
end
