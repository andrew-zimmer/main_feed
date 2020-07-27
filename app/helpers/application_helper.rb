module ApplicationHelper
    def dashboard_first_option
        "Users" if user_signed_in? && current_user.super_admin?
    end

    def link_to_path(user)
        if user.foreman
            link_to user.full_name, foreman_path(user.foreman)
        elsif user.helper
            link_to user.full_name, helper_path(user.helper)
        else
            link_to user.full_name, user_path(user)
        end
    end

    def sign_in_sign_up_or_sign_out
        if user_signed_in?
            link_to "Logout", logout_path, method: :delete
        else
            render partial: 'users/sign_in'
        end
    end

    def role?
        current_user.role if user_signed_in?
    end

    def current_user_full_name
        if user_signed_in?
            current_user.full_name
        else
            "Not logged in"
        end
    end

end
