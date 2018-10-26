Rails.application.routes.draw do
  root 'course#top'
  get 'top' => 'course#top'
  post 'list' => 'course#list'
  get 'detail' => 'course#detail'
  get 'pdf' => 'course#pdf'
end
