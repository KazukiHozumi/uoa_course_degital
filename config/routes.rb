Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'top' => 'course#top'
  get 'list' => 'course#list'
  get 'detail' => 'course#detail'
  get 'pdf' => 'course#pdf'
end
