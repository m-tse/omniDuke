jQuery ->
    loadEventHandlers()

loadEventHandlers = ->
    loadSectionBgColorChanger()


loadSectionBgColorChanger = ->
    $(".click-section").live('click', (e)->
        $(this).css('background-color', '#33FF99')
    )