(function() {
  $(function() {
    $('.best_in_place').best_in_place();
    $('.nav a').each(function() {
      if ($(this).attr('href') === $(location).attr('pathname')) {
        return $(this).parent().addClass("active");
      }
    });
    return Tipped.create('.tipped');
  });

}).call(this);
