class IncidentsController
  init: ->

  show: ->
   tour = new Tour(debug: true);
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
   #tour.start(true);






this.ServeUs.incidents = new IncidentsController()