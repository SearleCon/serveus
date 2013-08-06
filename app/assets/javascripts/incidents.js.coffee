class IncidentsController

  tour =  null

  init: ->

  show: ->
    tour = new Tour(debug:true)
    tour.addSteps [
      element: "#announcement"
      title: "Info box"
      content: "Click here to add a new interaction"
      placement: "bottom"
    ,
      element: "#incidents_menu"
      title: "Info box"
      content: "Use this menu to return home, send email, search interactions and print incident."
      placement: "right"
    ]
    tour.start() if first_time_user

    $('#help').on 'click', (e) ->
     e.preventDefault()
     if tour.ended()
       tour.restart()
     else
       tour.end()





this.ServeUs.incidents = new IncidentsController()