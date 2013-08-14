class TrashController
  init: ->
  index: ->
    checkboxes = $("input[type='checkbox']")
    emptyButton = $('#empty_trash')
    restoreButton = $('#restore_trash')

    checkboxes.click ->
      emptyButton.attr("disabled", !checkboxes.is(":checked"))
      restoreButton.attr("disabled", !checkboxes.is(":checked"))





this.ServeUs.trash = new TrashController()