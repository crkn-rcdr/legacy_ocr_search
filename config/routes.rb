Rails.application.routes.draw do
    resources :search_object do
        collection do
          post :search  # creates a route called search_objects_search
        end
    end
end
