class ForemenController < ApplicationController
    def index
    end

    def show
        @foremen = Foreman.all
    end
end
