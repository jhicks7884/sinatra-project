class CreateUsers < ActiveRecord::Migration
  def change
    create_table "users", force: :cascade do |t|
      t.string  "username"
      t.string  "email"
      t.string  "password_digest"
      
    end
  
  end
end
