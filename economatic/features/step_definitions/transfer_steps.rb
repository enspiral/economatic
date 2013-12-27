require 'economatic/contexts/approve_transfer'

When /^([^ ]*) transfers (#{CAPTURE_MONEY}) from (#{CAPTURE_ACCOUNT}) to (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION})$/ do |user_name, amount, source_account, destination_account, description|
  user = @users[user_name]
  amount = amount.fractional.to_s #check that composer works correctly
  play.transfer_money(
    source_account: source_account,
    destination_account: destination_account,
    creator: user,
    amount: amount,
    description: description
  )
end

Then /^(#{CAPTURE_ACCOUNT}) has a (#{CAPTURE_MONEY}) transfer by ([^ ]*) (to|from) (#{CAPTURE_ACCOUNT})(#{CAPTURE_WITH_DESCRIPTION}) in the transfer log$/ do |target_account, amount, user_name, to_from, actor_account, description|
  user = @users[user_name]

  # This is really complex logic to be in a test. If we need the Play to perform
  # this for us, it should be in a context (and it should be way nicer code).
  # If we don't need the Play to perform this, why are we testing it?

  if to_from == 'to'
    source_account = target_account
    destination_account = actor_account
  else
    source_account = actor_account
    destination_account = target_account
  end

  source_entry_scope = source_account.entries.where(amount_cents: -amount.cents)
  source_entry_scope.should exist

  destination_entry_scope = destination_account.entries.where(amount_cents: amount.cents)
  destination_entry_scope.should exist

  valid_transfer_ids = source_entry_scope.map(&:transfer_id) & destination_entry_scope.map(&:transfer_id)

  transfer_scope = Economatic::Transfer.where(id: valid_transfer_ids, creator_id: user.id)
  transfer_scope = transfer_scope.where(description: description) unless description.blank?
  transfer_scope.should exist
end

When /^([^ ]*) approves transfer "(.*?)" with description "(.*?)"$/ do |user_name, transfer_description, approval_description|
  user = @users[user_name]
  transfer = Economatic::Transfer.where(description: transfer_description).first
  transfer.should_not be_nil

  play.approve_transfer(
    transfer: transfer,
    description: approval_description,
    approver: user
  )
end