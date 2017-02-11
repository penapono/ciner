function addVisit(controller, action, resource_id, path, user_id) {
  $.ajax({
    url: "/api/v1/visits",
    type: "POST",
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    data: {
      'visit[user_id]': user_id,
      'visit[controller]': controller,
      'visit[action]': action,
      'visit[resource_id]': resource_id,
      'visit[path]': path
    }
  });
}
