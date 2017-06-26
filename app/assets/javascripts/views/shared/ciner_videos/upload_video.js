$(document).ready(function() {
  var bar = $('.bar');
  var percent = $('.percent');
  var status = $('#status');

  $('form').ajaxForm({
    forceSync: true,
    beforeSend: function() {
      status.empty();
      var percentVal = '0%';
      bar.width(percentVal);
      percent.html(percentVal);
    },
    uploadProgress: function(event, position, total, percentComplete) {
      console.log(percentComplete);
      console.log("Position: "+ position);
      console.log("Total: "+ total);
      console.log(position + "/" + total)
      var percentVal = percentComplete + '%';
      bar.width(percentVal);
      percent.html(percentVal);
    },
    complete: function(xhr) {
      console.log("Terminou!");
      console.log(xhr.responseText);
    },
    success: function(data) {
      console.log(data);
      console.log("Sucesso!");
      window.location.href = data.to;
    }
  });
});

// $(document).ready(function() {
//   var multiple_photos_form = $('form.edit_ciner_video');
//   var wrapper = multiple_photos_form.find('.progress-wrapper');
//   var progress_bar = wrapper.find('.progress-bar');

//   $('form.edit_ciner_video').on('fileuploadstart', function() {
//     alert("start");
//     wrapper.show();
//   });

//   $('form.edit_ciner_video').on('fileuploaddone', function() {
//     alert("done");
//     wrapper.hide();
//     progress_bar.width(0); // Revert progress bar's width back to 0 for future uploads
//   });

//   $('form.edit_ciner_video').on('fileuploadprogressall', function(e, data) {
//     alert("progress");
//     var progress = parseInt(data.loaded / data.total * 100, 10);
//     progress_bar.css('width', progress + '%').text(progress + '%');
//   });
// });
