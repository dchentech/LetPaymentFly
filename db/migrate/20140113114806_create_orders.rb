class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string      :payment_id
      t.boolean     :status,     :default => false
      t.timestamps
    end
    add_index :orders, [:payment_id], unique: true
  end
end
