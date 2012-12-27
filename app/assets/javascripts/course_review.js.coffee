###

jQuery ->

    criteria = [
        "usefulness"
        "stimulating"
        "content_quality"
        "homework_difficulty"
        "lab_difficulty"
        "midterm_difficulty"
        "final_difficulty"
    ]

    for criterion in criteria
        for level in [0..10]
            $('#'+criterion+level.toString()).click( ->
                $('#course_review'+criterion).val(level.toString())
                unhighlightAll(criterion, "grey")
            )
            $('#'+criterion+level.toString()).hover((-> 
                highlightToLeft(criterion, level, "red"))
                , (-> unhighlightAll(criterion, "grey"))
            )

highlightToLeft = (criteria, level, color) -> 
  for i in [0..level]
    idTag = "#"+criteria+i.toString()
    alert(idTag)
    $(idTag).css("background-color", color)
  

unhighlightAll = (criteria, color) ->
  for i in [0..10]
    criterionValue=0;
    ratingString = $("#course_review_"+criteria).val()
    if ratingString!=""
      criterionValue = parseInt(ratingString)
    idTag = "#"+criteria+i.toString()
    if criterionValue<i
      $(idTag).css("background-color", color)

###
