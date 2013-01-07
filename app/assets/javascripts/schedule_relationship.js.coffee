
jQuery ->
    loadEventHandlers()

loadEventHandlers = ->
    triggerUpPointer()
    coinFlipHandler()

triggerUpPointer = ->
    $("div#trigger-point-up").live("click", (e)->
        justAdded = $("#just-added")
        conflictingWith = $("#conflicting-with")
        setTimeout((->
            justAdded.removeClass("red-border", 1000)
            conflictingWith.removeClass("red-border", 1000)
        ), 1000)
        justAdded.addClass("red-border", 1000)
        conflictingWith.addClass("red-border", 1000)
    )

coinFlipHandler = ->
    $("div#coin-flip").live("click", (e)->
        if Math.random() > 0.5
            selector = "#just-added"
        else
            selector = "#conflicting-with"
        selected = $(selector)  
        setTimeout((->
            selected.removeClass("red-border", 1000)
        ), 1000)
        selected.addClass("red-border", 1000)
    )