class RecipesController < ApplicationController
    before_action :authorize

    def index
        render json: Recipe.all, include: :user, status: :created
    end

    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create(recipe_params)
        if recipe.valid?
            render json: recipe, include: :user, status: :created
        else
            render json: { errors: ["Invalid Details!"] }, status: :unprocessable_entity
        end
      end

    private

    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
