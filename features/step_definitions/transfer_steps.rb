require 'approve_transfer_context'

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

Then /^(#{CAPTURE_ACCOUNT}) has a (#{CAPTURE_MONEY}) transfer by ([^ ]*) (to|from) (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION}) in the transfer log$/ do |target_account, amount, user_name, to_from, actor_account, description|
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

  source_transaction_scope = source_account.transactions.where(amount_cents: -amount.cents)
  source_transaction_scope.should exist

  destination_transaction_scope = destination_account.transactions.where(amount_cents: amount.cents)
  destination_transaction_scope.should exist

  valid_transfer_ids = source_transaction_scope.map(&:transfer_id) & destination_transaction_scope.map(&:transfer_id)

  transfer_scope = Transfer.where(id: valid_transfer_ids, creator_id: user.id)
  transfer_scope = transfer_scope.where(description: description) unless description.blank?
  transfer_scope.should exist
end



When /^([^ ]*) approves transfer "(.*?)" with description "(.*?)"$/ do |user_name, transfer_description, approval_description|
  user = @users[user_name]
  transfer = Transfer.where(description: transfer_description).first
  transfer.should_not be_nil

  ApproveTransferContext.new(
      transfer: transfer,
      description: approval_description,
      approver: user
  ).call
end