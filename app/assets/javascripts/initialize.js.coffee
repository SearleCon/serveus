# execute page specific javascripts
(($, undefined_) ->
  $ ->
    $body = $("body")
    controller = $body.data("controller").replace(/\//g, "_")
    action = $body.data("action")
    activeController = ServeUs[controller]
    if activeController isnt `undefined`
      activeController.init()  if $.isFunction(activeController.init)
      activeController[action]()  if $.isFunction(activeController[action])

) jQuery


# Confirmation boxes
myCustomConfirmBox = (message, callback) ->
  bootbox.confirm message, "Cancel", "Yes", (confirmed) ->
    callback()  if confirmed

$.rails.allowAction = (element) ->
  message = element.data("confirm")
  answer = false
  callback = undefined
  return true  unless message
  if $.rails.fire(element, "confirm")
    myCustomConfirmBox message, ->
      callback = $.rails.fire(element, "confirm:complete", [answer])
      if callback
        oldAllowAction = $.rails.allowAction
        $.rails.allowAction = ->
          true

        element.trigger "click"
        $.rails.allowAction = oldAllowAction

  false


# BlockUI - Ajax and Turbolinks requests
$.blockUI.defaults.message ='<img src="/assets/loading.gif" />';
$(document).ajaxStart($.blockUI).ajaxStop $.unblockUI
$(document).on "page:fetch", $.blockUI
$(document).on "page:receive", $.unblockUI


# Fetch time
Temporal.detect

# Flash messages
$ ->
 $('.datetime').datetimepicker();
 $('.carousel').carousel();



#Popovers
$.fn.popover.defaults.html= true;
$.fn.popover.defaults.placement='right';
$.fn.popover.defaults.trigger='manual';


$(document).on 'click','#help',(e) ->
  e.preventDefault()
  $("[rel='popover']").popover('toggle')

$(document).on 'click','#toggle_search',(e) ->
  e.preventDefault()
  $(".search").fadeToggle("slow", "linear");



$(document).on 'click', '#restore_trash',(evt) ->
  evt.preventDefault()
  bootbox.confirm "Are you sure?",(result) ->
   if result
     $.ajax
       type: 'PATCH'
       url: $('#restore_trash').data('url')
       data:$('#trashcan').serialize()
       dataType: 'script'


$(document).on 'click', '#empty_trash',(evt) ->
  evt.preventDefault()
  bootbox.confirm "This cannot be undone, Are you sure?",(result) ->
   if result
    $.ajax
      type: 'DELETE'
      url: $('#empty_trash').data('url')
      data:$('#trashcan').serialize()
      dataType: 'script'



