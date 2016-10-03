class PaymentsController < ApplicationController
    TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]
  def new
    @client_token = Braintree::ClientToken.generate
    $user = Braintree::Customer.create
    $id = $user.customer.id
    render 'new.html.erb'
  end

  def create
    payment = Braintree::PaymentMethod.create(
      :customer_id => $id,
      :payment_method_nonce => params["payment-method-nonce"],
      :options => {
        :verify_card => true
      }
    )
    $result = Braintree::Transaction.sale(
      :customer_id => $id,
      :amount => "1.00", 
      :options=> {
        :submit_for_settlement => true
        })

    if $result.success?

      "A" * 50  #to see on terminal
    puts $result.transaction.type
       "A" * 50
    puts $result.transaction.status
    render 'show.html.erb'
  else
    redirect_to "/payments/new"
    end

      
  end

def show
 
end



end


