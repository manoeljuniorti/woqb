require 'qbwc'
class InvoiceAddWorker < QBWC::Worker

  def self.requests(params)
    {

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
