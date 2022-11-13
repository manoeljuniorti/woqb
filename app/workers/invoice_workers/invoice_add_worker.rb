require 'qbwc'
class InvoiceAddWorker < QBWC::Worker

  def self.requests(params)
    {
      invoice_add_rq:{
        invoice_add:{
          customer_ref:{
            full_name: params[:customer_name]
          },
          template_ref:{
            full_name: params[:template_name]
          },
          customer_memo:{
            value: params[:customer_memo]
          },
        }.merge(invoice_line_add(params[:invoice_itens]))
      },
    }
  end

  def invoice_line_add(invoice_itens)
    itens = []
    invoice_itens.each do |item|
      itens << invoice_line_add:{
        item_ref:{
          full_name: item[:full_name]
        },
        quantity: item[:quantity],
        description: item[:description],
        price_each: item[:price_each],
        amount: item[:amount],
      }
    end
  end

  def handle_response(r, session, job, request, data)
    {
      response: r,
      session: session,
      job: job,
      request: request,
      data: data,
    }
  end
end
