require 'transaction'
require 'authorisable'

class TransferMoneyContext
  #bank:
  #source_account:
  #destination_account:
  #creator:
  #amount:
  #time
  def initialize(actors)
    @bank = actors.delete(:bank)
    actors[:creator].extend Authorisable
    @transaction_arguments = actors
  end

  def creator
    @transaction_arguments[:creator]
  end

  def source_account
    @transaction_arguments[:source_account]
  end

  def call
    @transaction_arguments[:time] ||= Time.now
    role = creator.role_for source_account
    raise 'Exception' unless role.can_transfer_from?
    Transaction.create!(@transaction_arguments)
  end
end
