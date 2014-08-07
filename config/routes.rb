V1FmiLicenta::Application.routes.draw do
  resources :comentariu_licentas
  resources :licenta_salvatas
  resources :licentas
  resources :sesiunes
  resources :comentariu_temas
  resources :comentariu_fisiers
  resources :comentariu_capitols
  resources :comentariu_licenta
  resources :todos
  resources :fisiers
  resources :capitols
  resources :licenta_salvata
  resources :licenta
  resources :alegeri_user_temas
  resources :temas
  resources :domenius
  resources :users

  get "admin_pagini/controlPanel" => "admin_pagini#controlPanel", as: "controlPanel"
  get "admin_pagini/userSpecializari" => "admin_pagini#userSpecializari", as: "userSpecializari"
  get "licenta_pagini/licentaHome" => "licenta_pagini#licentaHome", as: "licentaHome"
  get "browse_pagini/browseHome" => "browse_pagini#browseHome"
  get "browse_pagini/alegerileMele" => "browse_pagini#alegerileMele", as: "alegerileMele"
  get "browse_pagini/studentiiMei" => "browse_pagini#studentiiMei", as: "studentiiMei"
  get "browse_pagini/temeleMele" => "browse_pagini#temeleMele", as: "temeleMele"
  get "browse_pagini/arhivaHome" => "browse_pagini#arhivaHome", as: "arhivaHome"
  get "browse_pagini/intreabaPage" => "browse_pagini#intreabaPage", as: "intreaba"

  get "domenius/new" => "domenius#new", as: "domeniuNew"
  get "temas/new" => "temas#new", as: "temaNew"


  match "/accepta" => "browse_pagini#accepta", :as => :accepta , via: [:get, :post] # pt a accepta licenta (partea de browse)
  match "intreaba/send", to: "browse_pagini#sendmail", via: "post"
  

  # omniauth
  get '/auth/:provider/callback', :to => 'user_sessions#create'
  get '/auth/failure', :to => 'user_sessions#failure' 
  get '/logout', :to => 'user_sessions#destroy'

  root to: "browse_pagini#browseHome"

end
