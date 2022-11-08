Rails.application.routes.draw do
  root 'qbwc#qwc'
  get 'qbwc/action' => 'qbwc#_generate_wsdl'
  get 'qbwc/qwc' => 'qbwc#qwc'
  wash_out :qbwc
  
  resources :wofficeqb do
    collection do
      post :create_client_app
      post :create_account_app

      get :find_client_app
      get :find_account_app
      get :add_customer
    end
  end
end
