$ ->

  $('.best_in_place').best_in_place()

  $('.nav a').each ->
    if $(@).attr('href') == $(location).attr('pathname')
      $(@).parent().addClass("active")

  Tipped.create('.tipped')

  