ActiveRecord::Schema.define() do
  create_table :transfers do |t|
    t.datetime :time
    t.integer  :creator_id
    t.string   :description
  end

  create_table :transactions do |t|
    t.integer :account_id, :transfer_id, :amount_cents
    t.boolean :pending, :default => false
  end

  create_table :transfer_approvals do |t|
    t.datetime :time
    t.integer  :approver_id
    t.string   :description
    t.integer  :transfer_id
  end

  create_table :accounts do |t|
    t.integer :bank_id
    t.decimal :minimum_balance_cents
    t.string  :type, :length => 15, :default => 'Account'
  end

  create_table :banks do |t|
  end

  create_table :users do |t|
    t.string :name
  end

  create_table :account_roles do |t|
    t.integer :user_id, :account_id
    t.string  :type
  end

  create_table :bank_roles do |t|
    t.integer :user_id, :bank_id
    t.string  :type
  end
end
