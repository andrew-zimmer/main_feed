module SchedulesHelper
    def current_week
        Date.today.strftime('%U')
    end

    def index_view(obj)
        if params[:user_id]
            render partial: 'schedules/users_nested_index', locals: {obj: obj}
        elsif params[:project_id]
            render partial: 'schedules/project_nested_index', locals: {obj: obj}
        else
            render partial: 'schedules/no_nested_index', locals: {obj: obj}
        end
    end

    def params_user
        User.find_by(id: params[:user_id])
    end

    def print_day(obj)
        obj.day_range.each do |t|
            time = Time.new(obj.year, obj.month, (obj.date.to_i + (t-1)).to_s)
            "#{time.strftime('%A')} #{time.strftime('%d')}: #{obj.project_name}"
        end

    end

end
