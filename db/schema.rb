ActiveRecord::Schema.define(:version => 20130320024738) do
  create_table :transactions do |t|
    t.integer :source_account
    t.integer :destination_account
    t.datetime :time
    t.decimal :amount
    t.integer :creator_id
  end
end