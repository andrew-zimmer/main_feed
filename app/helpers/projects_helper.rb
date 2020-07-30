module ProjectsHelper
    def title_link_if_in_index_view(obj)
        if params[:id]
            obj.name
        else
            link_to obj.name, project_path(obj)
        end
    end
end
