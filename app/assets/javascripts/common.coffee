$ ->

  $('.best_in_place').best_in_place()

  $('.nav a').each ->
    if $(@).attr('href') == $(location).attr('pathname')
      $(@).parent().addClass("active")

  Tipped.create('.tipped')

  $("#admin_categories_jstree").jstree
    json_data:
      ajax:
        url: "/admin/categories.json"
        data: (n) ->
          id: (if n.attr then n.attr("id") else '')
    plugins: ["themes", "json_data", "ui", "crrm", "contextmenu"]
