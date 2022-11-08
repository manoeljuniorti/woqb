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
    data = {
      customer_add_rq: {
        customer_add: {
          name: 'Gabriel'
        }
      }
    }

    QBWC.add_job('Add Gabriel', true, '', CustomerAddWorker, data)
  end

  private
  def client_app_params
    params.permit(:name, :description, :public_key, :secret_key, :active)
  end

  def account_app_params
    params.permit(:name, :tenant, :client_app_id, :quickbooks_data)
  end
end