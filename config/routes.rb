V1FmiLicenta::Application.routes.draw do
  resources :comentariu_temas
  resources :comentariu_fisiers
  resources :comentariu_capitols
  resources :comentariu_licentas
  resources :licenta_salvatas
  resources :licentas
  resources :todos
  resources :fisiers
  resources :capitols
  resources :alegeri_user_temas
  resources :temas
  resources :domenius
  resources :users
  resources :sesiunes

  get "admin_pagini/controlPanel" => "admin_pagini#controlPanel", as: "controlPanel"
  get "admin_pagini/userSpecializari" => "admin_pagini#userSpecializari", as: "userSpecializari"
  get "browse_pagini/browseHome" => "browse_pagini#browseHome"
  get "browse_pagini/alegerileMele" => "browse_pagini#alegerileMele", as: "alegerileMele"
  get "browse_pagini/studentiiMei" => "browse_pagini#studentiiMei", as: "studentiiMei"
  get "browse_pagini/temeleMele" => "browse_pagini#temeleMele", as: "temeleMele"
  get "browse_pagini/arhivaHome" => "browse_pagini#arhivaHome", as: "arhivaHome"
  get "browse_pagini/intreabaPage" => "browse_pagini#intreabaPage", as: "intreaba"
  get "licenta_pagini/licentaHome" => "licenta_pagini#licentaHome", as: "licentaHome"

  get "domenius/new" => "domenius#new", as: "domeniuNew"
  get "temas/new" => "temas#new", as: "temaNew"
  get "fisiers/:id/download" => "fisiers#download", as: "download_fisier"

  match "/accepta" => "browse_pagini#accepta", :as => :accepta , via: [:get, :post] # pt a accepta licenta (partea de browse)
  match "intreaba/send", to: "browse_pagini#sendmail", via: "post"
  match "licentaHome/adauga_comentariu", to: "licenta_pagini#adauga_comentariu", via: "post"
  match "fisiers/adauga_comentariu", to: "fisiers#adauga_comentariu", via: "post"
  match "capitols/adauga_comentariu", to: "capitols#adauga_comentariu", via: "post"

  # omniauth
  get '/auth/:provider/callback', :to => 'user_sessions#create'
  get '/auth/failure', :to => 'user_sessions#failure' 
  get '/logout', :to => 'user_sessions#destroy'

  root to: "browse_pagini#browseHome"

end
