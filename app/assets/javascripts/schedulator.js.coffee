jQuery ->
    loadEventHandlers()

loadEventHandlers = ->
    sectionBgColorChanger()
    scheduleNameUpdater()


sectionBgColorChanger = ->
    $(".click-section").live('click', (e)->
        section = $(this)
        if section.hasClass('bg-light-green') 
            section.removeClass('bg-light-green')
        else
            section.addClass('bg-light-green')
    )

scheduleNameUpdater = ->
    $(".scheduleNameUpdate").live("click", (e)->
        $("#scheduleName").html($(this).html())
    )

historyHandler = ->
    if history && history.pushState
        jQuery ->
            $(".updateHistory a").live("click", (e)->
                history.pushState(null, "", this.href)
                e.preventDefault()
            )
            $(window).bind('popstate', ->
                  $.getScript(location.href)
            )