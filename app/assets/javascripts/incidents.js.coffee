class IncidentsController
  init: ->

  show: ->
    $('.editable').editable({
      ajaxOptions: {
        type: 'patch'
      }
    });


this.ServeUs.incidents = new IncidentsController()



