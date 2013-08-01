class InteractionsController
  init: ->
  edit: ->
    $(".tm-input").tagsManager({typeaheadAjaxSource: '/tags', tagClass:'tm-tag-info', typeahead: true, hiddenTagListId: 'tags' });
    $('.datetime').datetimepicker();



this.ServeUs.interactions = new InteractionsController()