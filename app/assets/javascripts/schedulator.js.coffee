jQuery ->
    loadEventHandlers()

loadEventHandlers = ->
    loadSectionBgColorChanger()


loadSectionBgColorChanger = ->
    $(".click-section").live('click', (e)->
        section = $(this)
        if section.hasClass('bg-light-green') 
            section.removeClass('bg-light-green')
        else
            section.addClass('bg-light-green')
    )