class EmailsController
  init: ->
  create: ->
    $(".tm-input").tagsManager({typeaheadAjaxSource: '/tags', tagClass:'tm-tag-info', typeahead: true, hiddenTagListId: 'tags' });
    $('.datetime').datetimepicker();




this.ServeUs.emails = new EmailsController()