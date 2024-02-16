Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      get '/', to: 'device_experiments#index'
    end
  end

end
