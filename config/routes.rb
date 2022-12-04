Rails.application.routes.draw do
  root 'items#index', as: 'home'
  get 'queries' => 'queries#list', as: 'queries_list'
  get 'queries/a' => 'queries#a', as: 'query_a'
  get 'queries/b' => 'queries#b', as: 'query_b'
  get 'queries/c' => 'queries#c', as: 'query_c'
  get 'queries/d' => 'queries#d', as: 'query_d'
  get 'queries/e' => 'queries#e', as: 'query_e'

  resources :items
end
