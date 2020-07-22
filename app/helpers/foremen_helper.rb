module ForemenHelper

    def foreman_all
        User.joins(:foreman)
    end

    def current_foreman
        Foreman.find_by(id: params[:id]).user.first_name
    end
end
