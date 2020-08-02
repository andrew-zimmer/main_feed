class SchedulesController < ApplicationController
    load_and_authorize_resource

    def show
    end

    def index
      if params[:project_id]
        project = Project.find_by(id: params[:project_id])
        @schedules = project.schedules
      elsif params[:user_id]
        user = User.find_by(id: params[:user_id])
        @schedules = user.schedules
      else
        @schedules = Schedule.all
      end
    end

    def new
    end

    def create
      @schedule = Schedule.new(schedule_params)
      if @schedule.save
        redirect_to schedules_path
      else
        @schedule
        render new_schedule_path(@schedule)
      end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def schedule_params
      params.require(:schedule).permit(:user_id, :project_id, :start_date, :end_date)
    end
end
