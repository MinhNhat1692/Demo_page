Rails.application.routes.draw do
  get 'homepage/home'

  get 'homepage/services'

  get 'homepage/reg', to: 'homepage#reg'

  get 'homepage/department_1'

  get 'homepage/department_2'

  get 'homepage/department_3'

  get 'homepage/department_4'

  get 'homepage/help_1'

  get 'homepage/help_2'

  get 'homepage/help_3'

  get 'homepage/info_1'

  get 'homepage/info_2'

  get 'homepage/info_3'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
