module Api
  class CategoriesController < ApplicationController

    def index
      render json: current_user.categories
    end

    def create
      category = current_user.categories.new(params[:category])

      if category.save
        render json: category
      else
      end
    end

    def update
      category = current_user.categories.find(params[:id])

      if category.update_attributes(params[:category])
        render json: category
      else
      end
    end

    def delete
      category = current_user.categories.find(params[:id])
      category.destroy
      render json: category
    end
  end
end
