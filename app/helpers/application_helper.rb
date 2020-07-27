module ApplicationHelper
    def dashboard_first_option
        "Users" if current_user.super_admin?
    end
end
