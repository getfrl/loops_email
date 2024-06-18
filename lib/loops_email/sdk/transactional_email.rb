
class LoopsEmail::Sdk::TransactionalEmail
  attr_accessor :receiver,
                :transaction_id,
                :variables


  def initialize(receiver:, transaction_id:, variables: {})
    @receiver = receiver
    @transaction_id = transaction_id
    @variables = variables
  end

  def call
    LoopsEmail::Client.new.post("/api/v1/transactional", body: payload)
  end

  def payload
    {
      transactionalId: transaction_id,
      email: receiver,
      dataVariables: variables
    }
  end
end