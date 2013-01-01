jQuery ->
    loadEventHandlers()

loadEventHandlers = ->
    hoverHandler()

hoverHandler = ->
    $(".clickable").hover((->
            hoverInHandler($(this))
        ),(->
            hoverOutHandler($(this))
        )
    )
    
hoverInHandler = (clickable) ->
    clickable.addClass("padding", 1000)
    alert("WORKING")

hoverOutHandler = (clickable) ->
    clickable.removeClass("padding", 1000)
    alert("WORKING")
