require 'qbwc'
module InvoiceWorkers
  class InvoiceAddWorker < QBWC::Worker

    def self.requests(params)
      {
        invoice_add_rq:{
          invoice_add:{
            customer_ref:{
              list_id: params[:customer_id]
            },
#            template_ref:{
#              full_name: params[:template_name]
#            },
            memo: params[:memo],
            invoice_line_add: {
              item_ref:{
                full_name: params[:invoice_line_add][:full_name]
              },
             quantity: params[:invoice_line_add][:quantity],
              desc: params[:invoice_line_add][:desc],
              amount: params[:invoice_line_add][:amount],
            },
         },
        },
      }
    end

    def self.invoice_line_add(invoice_itens)
      itens = []
      invoice_itens.each do |item|
        itens << {
        item_ref:{
          full_name: item[:full_name]
        },
        quantity: item[:quantity],
        desc: item[:desc],
        amount: item[:amount],
      }
      end
      itens
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
end
