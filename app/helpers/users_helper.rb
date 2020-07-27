module UsersHelper
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
