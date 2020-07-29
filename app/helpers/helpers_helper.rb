module HelpersHelper
    def index_title_if_nested_or_not
         if params[:foreman_id]
            render partial: 'helpers/nested_title', locals: {foreman: @foreman}
         else
            content_tag(:h1, "Helper's Index")
         end
    end

    def buttom_route_if_nested_or_not
         if params[:foreman_id]
             link_to "Add Helper", new_foreman_helper_path(@foreman)
         else
             link_to "New Helper", new_helper_path
         end
    end
end
