class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table "deliveries", force: :cascade do |t|
      t.string  "name"
      t.string  "address"
      t.string  "content"
      t.integer "user_id"
    end
  end
end
