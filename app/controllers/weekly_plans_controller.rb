class WeeklyPlansController < ApplicationController
  # GET /weekly_plans
  # GET /weekly_plans.json
  def index
    @weekly_plans = WeeklyPlan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @weekly_plans }
    end
  end

  # GET /weekly_plans/1
  # GET /weekly_plans/1.json
  def show
    @weekly_plan = WeeklyPlan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @weekly_plan }
    end
  end

  # GET /weekly_plans/new
  # GET /weekly_plans/new.json
  def new
    @weekly_plan = WeeklyPlan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @weekly_plan }
    end
  end

  # GET /weekly_plans/1/edit
  def edit
    @weekly_plan = WeeklyPlan.find(params[:id])
  end

  # POST /weekly_plans
  # POST /weekly_plans.json
  def create
    @weekly_plan = WeeklyPlan.new(params[:weekly_plan])

    respond_to do |format|
      if @weekly_plan.save
        format.html { redirect_to @weekly_plan, notice: 'Weekly plan was successfully created.' }
        format.json { render json: @weekly_plan, status: :created, location: @weekly_plan }
      else
        format.html { render action: "new" }
        format.json { render json: @weekly_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /weekly_plans/1
  # PUT /weekly_plans/1.json
  def update
    @weekly_plan = WeeklyPlan.find(params[:id])

    respond_to do |format|
      if @weekly_plan.update_attributes(params[:weekly_plan])
        format.html { redirect_to @weekly_plan, notice: 'Weekly plan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @weekly_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_plans/1
  # DELETE /weekly_plans/1.json
  def destroy
    @weekly_plan = WeeklyPlan.find(params[:id])
    @weekly_plan.destroy

    respond_to do |format|
      format.html { redirect_to weekly_plans_url }
      format.json { head :no_content }
    end
  end
end
