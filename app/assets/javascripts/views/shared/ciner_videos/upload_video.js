// $(document).ready(function() {
//   var bar = $('.bar');
//   var percent = $('.percent');
//   var status = $('#status');

//   $('form').ajaxForm({
//     forceSync: true,
//     beforeSend: function() {
//       status.empty();
//       var percentVal = '0%';
//       bar.width(percentVal);
//       percent.html(percentVal);
//     },
//     uploadProgress: function(event, position, total, percentComplete) {
//       console.log(percentComplete);
//       console.log("Position: "+ position);
//       console.log("Total: "+ total);
//       console.log(position + "/" + total)
//       var percentVal = percentComplete + '%';
//       bar.width(percentVal);
//       percent.html(percentVal);
//     },
//     complete: function(xhr) {
//       console.log("Terminou!");
//       console.log(xhr.responseText);
//     },
//     success: function(data) {
//       console.log(data);
//       console.log("Sucesso!");
//       window.location.href = data.to;
//     }
//   });
// });
