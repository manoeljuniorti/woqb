require 'qbwc'
class WofficeqbController < ApplicationController
  def create_client_app
   data = ClientApp.create(client_app_params)
   render json: data
  end

  def create_account_app
    data = AccountApp.create(account_app_params)
    render json: data
  end

  def find_client_app
    render json: ClientApp.find_by(id: params[:id])
  end

  def find_account_app
    render json: AccountApp.find_by(id: params[:id])
  end

  def add_customer
    data = CustomerWorkers::CustomerAddWorker.requests

    QBWC.add_job('Add Gabriel', true, '', CustomerWorkers::CustomerAddWorker, data)
  end

  def add_invoice
    data = InvoiceWorkers::InvoiceAddWorker.requests

    QBWC.add_job('Invoice Gabriel', true, '', InvoiceWorkers::InvoiceAddWorker, data)
  end

  def find_invoice
    #render json: 
  end

  private
  def client_app_params
    params.permit(:name, :description, :public_key, :secret_key, :active)
  end

  def account_app_params
    params.permit(:name, :tenant, :client_app_id, :quickbooks_data)
  end

  def customer_params
    params.permit(:name, :active, :company_name, :salutation, :first_name, :last_name, :addr1, :city, :state, :postal_code, :phone, :alt_phone, :email, :full_name, :account_number, :credit_limit)
  end

  def invoice_params
    params.permit()
  end
end