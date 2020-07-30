class ProjectsController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def index
  end

  def new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project)
    else
      @project
      render new_project_path
    end
  end

  def edit
  end

  def update
    project = find_by_params_id
    if project.update(project_params)
      redirect_to project_path(project)
    else
      render edit_project_path(project)
    end
  end

  def destroy
    project = find_by_params_id
    project.destroy
    redirect_to projects_path, notice: 'Good job bitchhhhhhhhhhh, you deleted it, bitchhhhhhh!'
  end

  private

  def project_params
    params.require(:project).permit(:name, :address, :project_number, :start_date, :end_date, :construction_type, :finish, :started)
  end

  def find_by_params_id
    Project.find_by(id: params[:id])
  end

end
