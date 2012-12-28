module SchedulatorHelper

    def isActiveClass(active, index)
        if active.nil?
            return false
        elsif (active == "current" && index == 1) || (active == "saved" && index == 2) 
            return true
        end
    end

end
