class ProjectsController < ApplicationController
  before_action :authenticate_user! # Forces login before doing anything
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show
    authorize @project
  end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    authorize @project
    if @project.save
      redirect_to @project, notice: "Project was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @project
  end

  def update
    authorize @project
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @project
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted!", status: :see_other
  end
  private

  def set_project
    @project = Project.find(params[:id])
  end

  # Strong parameters to safely whitelist form fields
  def project_params
    params.require(:project).permit(:title, :description)
  end
end
