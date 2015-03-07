class PlanController < ApplicationController

  before_filter :require_current_user

  # GET /activities
  # GET /activities.json
  def index
    @activities = current_user.activities.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = current_user.activities.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = current_user.activities.new
    @categories = current_user.categories

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
    @categories = current_user.categories

    respond_to do |format|
      format.html
      format.json { render json: render_to_string('_mini_form', layout: false, formats: [:html]) }
    end

  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = current_user.activities.create!(params[:activity])
    redirect_to plan_index_path, notice: 'Activity was successfully created.'
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = current_user.activities.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.json { render json: {activity: render_to_string('_mini_activity', layout: false, formats: [:html], locals: {activity: @activity})} }
        format.html { redirect_to plan_index_path, notice: 'Activity was successfully updated.' }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def delete
    @activity = current_user.activities.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to manage_url }
      format.json { head :no_content }
    end
  end

  private

  def require_current_user
    unless current_user
      head :forbidden
    end
  end
end
