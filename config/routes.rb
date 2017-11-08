Rails.application.routes.draw do
  mount MagicLamp::Genie, at: "/magic_lamp" if defined?(MagicLamp)
  devise_for :users
  resources :users, only: [:create]
  get '/users/edit' => 'users#edit'
  patch '/users/edit' => 'users#update'

  get '/laurels/:slug' => 'laurels#show', as: :laurel
  get '/laurels' => 'laurels#index'
  get '/laurels/:slug/contact' => 'contact#new', as: :contact_laurel
  post 'laurels/:slug/contact' => 'contact#create'

  namespace :laurel do
    get '/groups' => 'groups#index'
    get '/groups/:name' => 'groups#show', as: :group
  end 

  get '/chambers' => 'users#index'

  namespace :chambers do
    resources :groups, only: [:index]
    get '/groups/:name' => 'groups#show', as: :group
    resources :images, only: [:create]
    resources :comments, only: [:create]

    namespace :laurel do
      resources :candidates, only: [:index, :show]
      get '/candidates/:id/poll_comments' => 'candidates#poll_comments', as: :poll_comments
      namespace :poll do
        get '/' => 'candidates#index', as: :candidates
        get '/candidates/:id' => 'candidates#edit', as: :edit_candidate
        resources :candidates, only: [:update]
      end

      namespace :admin do
        resources :laurels
        resources :candidates, except: :show
        resource :poll, except: [:destroy, :show]
      end
    end
  end

  scope :chambers do
    namespace :admin do
      resources :royalty, except: [:destroy, :show] 
    end 
  end

  root to: "home#index" 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
