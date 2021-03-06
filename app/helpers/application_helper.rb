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

    def link_path(user)
        if user.foreman
            foreman_path(user.foreman)
        elsif user.helper
            helper_path(user.helper)
        else
            user_path(user)
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

    def link_path_for_foreman_helper_or_user(user)
        if user.class == User
            if user.foreman
                link_to user.full_name, foreman_path(user.foreman)
            elsif user.helper
                link_to user.full_name, helper_path(user.helper)
            else
                link_to user.full_name, user_path(user)
            end
        elsif user.class == Foreman
            link_to user.full_name, foreman_path(user)
        else
            link_to user.full_name, helper_path(user)
        end
    end

    def show_add_helper_foreman_or_neither(user)
        if user.class == Foreman
            content_tag :li, (render partial: 'helper_list', locals: {t: user})
        elsif user.class == Helper
            content_tag :li, (render partial: 'helpers/foreman_link', locals: {user: user})
        end
    end

end
