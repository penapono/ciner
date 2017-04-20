//= require views/shared/index

$(function(){
  $(document).on('click', "[data-check-all] input[type='checkbox']", function(){
    var self = $(this),
        parent = self.closest('[data-bulk-delete]'),
        checkboxes = parent.find("[data-selectable] input[type='checkbox']");

    checkboxes.each(function(index) {
      $(this).prop('checked', self.prop('checked'));
    });
  });

  $(document).on('click', '[data-bulk-delete] [data-trash]', function(){
    var self = $(this),
        parent = self.closest('[data-bulk-delete]'),
        checkboxes = parent.find("[data-selectable] input[type='checkbox']"),
        ids = [],
        i = 0;

    checkboxes.each(function(index) {
      if ($(this).prop('checked')) {
        var itemCheckbox = $(this).closest('[data-item-checkbox]');
        ids[i++] = itemCheckbox.data("movie-id");
      }
    });

    $.ajax({
      url: "/admin/movies/bulk_destroy",
      type: "POST",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
      data: {
        'destroy[ids]': ids
      },
      success: function(d) {
        checkboxes.each(function(index) {
          $(this).prop('checked', false)
        });

        $("[data-check-all] input[type='checkbox']").prop('checked', false);
        location.reload();
      },
      error: function(data) {
        console.log("Não funcionou!");
      }
    });


  });
});
