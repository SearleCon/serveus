class InteractionsController
  init: ->
  edit: ->
    $(".tm-input").tagsManager({typeaheadAjaxSource: '/tags', tagClass:'tm-tag-info', typeahead: true, hiddenTagListId: 'tags' });
    $('.datetime').datetimepicker();
    $('input[type=file]').bootstrapFileInput();




this.ServeUs.interactions = new InteractionsController()