require 'qbwc'
module CostumerWorkers
  class CustomerAddWorker < QBWC::Worker

    def self.requests(params)
      {
        customer_add_rq: {
          customer_add: {
            name: params[:name],
            active: params[:active],
            company_name: params[:company_name],
            salutation: params[:salutation],
            first_name: params[:first_name],
            last_name: params[:last_name],
            addr1: params[:addr1],
            city: params[:city],
            state: params[:state],
            postal_code: params[:postal_code],
            phone: params[:phone],
            alt_phone: params[:alt_phone],
            email: params[:email],
            full_name: params[:full_name],
            account_number: params[:account_number],
            credit_limit: params[:credit_limit],
          }
        }
      }
    end

    def handle_response(r, session, job, request, data)
      # handle_response will get customers in groups of 100. When this is 0, we're done.
      complete = r['xml_attributes']['iteratorRemainingCount'] == '0'

      r['customer_ret'].each do |qb_cus|
        qb_id = qb_cus['list_id']
        qb_name = qb_cus['name']
        puts "#{qb_id} #{qb_name}"
      end
    end
  end
end
