(function() {
  $(function() {
    $('.best_in_place').best_in_place();
    $('.nav a').each(function() {
      if ($(this).attr('href') === $(location).attr('pathname')) {
        return $(this).parent().addClass("active");
      }
    });
    Tipped.create('.tipped');
    return $("#admin_categories_jstree").jstree({
      json_data: {
        ajax: {
          url: "/admin/categories.json",
          data: function(n) {
            return {
              id: (n.attr ? n.attr("id") : '')
            };
          }
        }
      },
      plugins: ["themes", "json_data", "ui", "crrm", "contextmenu"]
    });
  });

}).call(this);
