class ManageController < ApplicationController
  
  def index
    @categories = current_user.categories.all
    @category = current_user.categories.build
  end

  def edit
    @category = current_user.categories.find(params[:id])
    self.class.layout false
  end

  def create
    @category = current_user.categories.new(params[:category])

    if @category.save
      redirect_to manage_url, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @category = current_user.categories.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to manage_url, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def delete
    @category = current_user.categories.find(params[:id])
    @category.destroy
    redirect_to manage_url
  end
end
