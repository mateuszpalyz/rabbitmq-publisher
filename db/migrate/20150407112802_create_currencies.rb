class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :uuid
      t.json :rates
      t.boolean :ack1
      t.boolean :ack2
      t.boolean :ack3

      t.timestamps null: false
    end
  end
end
