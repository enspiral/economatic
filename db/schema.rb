ActiveRecord::Schema.define() do
  create_table :transactions do |t|
    t.integer :source_account_id
    t.integer :destination_account_id
    t.datetime :time
    t.decimal :amount
    t.integer :creator_id
  end

  create_table :accounts do |t|

  end
end
