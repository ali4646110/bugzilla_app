class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_bug, only: %i[show edit update destroy]

  # GET /projects/:project_id/bugs
  def index
    @bugs = @project.bugs
  end

  # GET /projects/:project_id/bugs/:id
  def show
    authorize @bug
  end

  # GET /projects/:project_id/bugs/new
  def new
    @bug = @project.bugs.new
    authorize @bug
  end

  # POST /projects/:project_id/bugs
  def create
    @bug = @project.bugs.new(bug_params)
    @bug.creator = current_user # Automatically sets the logged-in user as the creator
    authorize @bug

    if @bug.save
      redirect_to project_path(@project), notice: "Bug was successfully reported!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /projects/:project_id/bugs/:id/edit
  def edit
    authorize @bug
  end

  # PATCH/PUT /projects/:project_id/bugs/:id
  def update
    authorize @bug
    if @bug.update(bug_params)
      redirect_to project_path(@project), notice: "Bug was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/:project_id/bugs/:id
  def destroy
    authorize @bug
    @bug.destroy
    redirect_to project_path(@project), notice: "Bug was successfully removed!", status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_bug
    @bug = @project.bugs.find(params[:id])
  end

  # Strong parameters: notice we allow assignee_id so devs can be assigned to bugs
  def bug_params
    params.require(:bug).permit(:title, :description, :status, :assignee_id)
  end
end
