ActiveRecord::Schema.define() do
  create_table :transactions do |t|
    t.integer :source_account_id
    t.integer :destination_account_id
    t.datetime :time
    t.integer :amount_cents
    t.integer :creator_id
    t.string :description
  end

  create_table :accounts do |t|
    t.integer :bank_id
    t.decimal :minimum_balance_cents
    t.string :type, :length => 15, :default => 'Account'
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

  create_table :bank_roles do |t|
    t.integer :user_id, :bank_id
    t.string :type
  end
end
