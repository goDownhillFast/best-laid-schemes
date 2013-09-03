function editActivityForm(activity) {
  $.ajax({url: '../plan/' + $(activity).attr('data-activity-id'),
    dataType: 'json',
    complete: function (response) {
      $(activity).replaceWith($(response.responseText).on('ajax:success', function (evt, response) {
        $(this).replaceWith(response.activity)
      }))
    }})
}

$(function () {
  $('body').on('click', '.edit-activity', function () {
    editActivityForm($(this).closest('.activity'))
  });

  $('body').on('click', '.form-submit', function () {
    $(this).closest('form').submit();
  });

  $('body').on('ajax:success', 'form.edit_activity', function (response) {
    $(this).replaceWith(response.responseText)
  });

  $('body').on('ajax:error', function (evt, data) {
    console.log(data.responseText)
  })

});