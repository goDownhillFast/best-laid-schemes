function editActivityForm(activity) {
  $.ajax({url: '../activities/' + $(activity).attr('data-activity-id') + '/edit',
    dataType: 'json',
  complete: function(response){
    $(activity).replaceWith($(response.responseText).on('ajax:success', function(evt, response){
          $(this).replaceWith(response.activity)}))
  }})
}

$(function(){
  $('body').on('click','.edit-activity', function(){
    editActivityForm($(this).closest('.activity'))
  });

  $('body').on('click','.form-submit', function(){
    $(this).closest('form').submit();
  });

  $('body').on('ajax:success', 'form.edit_activity', function(response){
    $(this).replaceWith(response.responseText)
  })
});