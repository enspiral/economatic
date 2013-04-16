require 'approve_transaction_context'

When /^([^ ]*) transfers (#{CAPTURE_MONEY}) from (#{CAPTURE_ACCOUNT}) to (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION})$/ do |user_name, amount, source_account, destination_account, description|
  user = @users[user_name]
  context = TransferMoneyContext.new(
      bank: @bank,
      source_account: source_account,
      destination_account: destination_account,
      creator: user,
      amount: amount,
      description: description
  )
  context.call
end

Then /^(#{CAPTURE_ACCOUNT}) has a (#{CAPTURE_MONEY}) transaction by ([^ ]*) (to|from) (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION}) in the transaction log$/ do |target_account, amount, user_name, to_from, actor_account, description|
  user = @users[user_name]

  # This is really complex logic to be in a test. If we need the app API to perform
  # this for us, it should be in a context (and it should be way nicer code).
  # If we don't need the API to perform this, why are we testing it?

  if to_from == 'to'
    source_account = target_account
    destination_account = actor_account
  else
    source_account = actor_account
    destination_account = target_account
  end

  source_variation_scope = source_account.variations.where(amount_cents: -amount.cents)
  source_variation_scope.should exist

  destination_variation_scope = destination_account.variations.where(amount_cents: amount.cents)
  destination_variation_scope.should exist

  valid_transaction_ids = source_variation_scope.map(&:transaction_id) & destination_variation_scope.map(&:transaction_id)

  transaction_scope = Transaction.where(id: valid_transaction_ids, creator_id: user.id)
  transaction_scope = transaction_scope.where(description: description) unless description.blank?
  transaction_scope.should exist
end



When /^([^ ]*) approves transaction "(.*?)" with description "(.*?)"$/ do |user_name, transaction_description, approval_description|
  user = @users[user_name]
  transaction = Transaction.where(description: transaction_description).first
  transaction.should_not be_nil

  ApproveTransactionContext.new(
      transaction: transaction,
      description: approval_description,
      approver: user
  ).call
end