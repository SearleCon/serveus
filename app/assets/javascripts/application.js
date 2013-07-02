// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.ui.effect-highlight
//= require jquery.remotipart
//= require jquery.blockUI
//= require bootstrap
//= require bootstrap-datetimepicker
//= require bootstrap-tagmanager
//= require bootbox
//= require editable/bootstrap-editable
//= require editable/rails
//= require temporal
//= require paloma
//= require turbolinks
//= require_tree .


$(document).ajaxStart($.blockUI).ajaxStop($.unblockUI);

$(document).ready(function() {
    $.rails.allowAction = function(element) {
        var message = element.data('confirm'),
            answer = false, callback;
        if (!message) { return true; }

        if ($.rails.fire(element, 'confirm')) {
            myCustomConfirmBox(message, function() {
                callback = $.rails.fire(element,
                    'confirm:complete', [answer]);
                if(callback) {
                    var oldAllowAction = $.rails.allowAction;
                    $.rails.allowAction = function() { return true; };
                    element.trigger('click');
                    $.rails.allowAction = oldAllowAction;
                }
            });
        }
        return false;
    }

    function myCustomConfirmBox(message, callback) {
        bootbox.confirm(message, "Cancel", "Yes", function(confirmed) {
            if(confirmed){
                callback();
            }
        });
    }

    Temporal.detect();
});
