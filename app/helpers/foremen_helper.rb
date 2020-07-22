module ForemenHelper

    def foreman_all
        User.joins(:foreman)
    end


end
