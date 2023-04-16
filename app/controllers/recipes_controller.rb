class RecipesController < ApplicationController
    def index
        user = User.find_by(id: session[:user_id])
        if user
            recipes = Recipe.all 
            render json: recipes, include: :user
        else 
            render json: { errors: ["Unauthorized access"]}, status: :unauthorized
        end 
    end 

    def create
        user = User.find_by(id: session[:user_id])
        if user 
            recipe = Recipe.create(user_id: session[:user_id], title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete])
            if recipe.valid?
                render json: recipe, include: :user, status: :created
            else 
                render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
        else 
            render json: { errors: ["Unauthorized access"] }, status: :unauthorized
        end 
    end
end
