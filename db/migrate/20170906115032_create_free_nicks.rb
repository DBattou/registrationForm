class CreateFreeNicks < ActiveRecord::Migration[5.1]
  def change
    create_table :free_nicks do |t|
      t.string :name

      t.timestamps
    end
  end
end
