module SchedulatorHelper

    def getActiveClass(active, index)
        if active.nil?
            return
        elsif (active == "new" && index == 1) || (active == "saved" && index == 2) 
            return "active" 
        end
    end

end
