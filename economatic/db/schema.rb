ActiveRecord::Schema.define() do
  create_table :transactions do |t|
    t.datetime :time
    t.integer  :creator_id
    t.string   :description
  end

  create_table :entries do |t|
    t.integer :account_id, :transaction_id, :amount_cents
    t.boolean :pending, :default => false
  end

  create_table :transaction_approvals do |t|
    t.datetime :time
    t.integer  :approver_id
    t.string   :description
    t.integer  :transaction_id
  end

  create_table :accounts do |t|
    t.integer :bank_id
    t.decimal :minimum_balance_cents
    t.string  :type, :length => 30, :default => 'Economatic::Account'
    t.string  :name
    t.text    :description
  end

  create_table :banks do |t|
    t.string :name
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
