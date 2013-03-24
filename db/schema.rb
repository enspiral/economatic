ActiveRecord::Schema.define() do
  create_table :transactions do |t|
    t.integer :source_account_id
    t.integer :destination_account_id
    t.datetime :time
    t.decimal :numeric_amount
    t.integer :creator_id
  end

  create_table :accounts do |t|
    t.integer :bank_id
    t.decimal :numeric_minimum_balance
  end

  create_table :banks do |t|

  end

  create_table :users do |t|
    t.string :name
  end

  create_table :account_roles do |t|
    t.integer :user_id, :account_id
    t.string :type
  end
end
