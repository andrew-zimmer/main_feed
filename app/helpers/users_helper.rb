module UsersHelper
    def check_for_foreman_and_helper_id(user)
        if user.class == Foreman || user.class == Helper
            user.user
        else
            user
        end
    end
end
