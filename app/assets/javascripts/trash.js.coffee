class TrashController
  init: ->
  index: ->
    $("input[type='checkbox']").click ->
      $('#empty_trash').attr("disabled", !$("input[type='checkbox']").is(":checked"))
      $('#restore_trash').attr("disabled", !$("input[type='checkbox']").is(":checked"))





this.ServeUs.trash = new TrashController()