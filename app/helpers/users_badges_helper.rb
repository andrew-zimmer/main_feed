module UsersBadgesHelper

    def new_nested_badge_path
        if params[:badge_id]
            link_to "Set Badge to Another User", new_badge_users_badge_path(params[:badge_id])
        else
            link_to "Create or Set Badge To Another User", new_users_badge_path
        end
    end

    def new_badge_form_if_nested_route(b)
        if !params[:badge_id]
            content_tag(:h3, "Or create a new badge")

            render partial: 'badges/form', locals: {f: b}

        end
    end

end
