(function() {

  $(function() {
    $('.nav a').each(function() {
      if ($(this).attr('href') === $(location).attr('pathname')) {
        return $(this).parent().addClass("active");
      }
    });
    return Tipped.create('.tipped');
  });

}).call(this);
