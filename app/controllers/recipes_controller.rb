class RecipesController < ApplicationController
    wrap_parameters format: []

    before_action :authorize

    def index
        recipes = Recipe.all
        render json: recipes, include: :user
    end

    def create
        recipe = Recipe.create!(id: session[:user_id])
        render json: recipe, status: :created
      end

    private

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    

end
