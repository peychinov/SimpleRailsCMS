$ ->

  $('.best_in_place').best_in_place()

  $('.nav a').each ->
    if $(@).attr('href') == $(location).attr('pathname')
      $(@).parent().addClass("active")

  Tipped.create('.tipped')

  bg = window.location.href.indexOf("/bg/") > -1

  $("#admin_categories_jstree").jstree(
    json_data:
      ajax:
        url: "/admin/categories.json"
        data: (n) ->
          id: (if n.attr then n.attr("id") else '')
    contextmenu:
      items:
        create:
          label: if bg then 'Създай' else 'Create'
        rename:
          label: if bg then 'Преименувай' else 'Rename'
        remove:
          label: if bg then 'Премахни' else 'Remove'
        ccp: false
    themes:
      url: '/assets/themes/default/style.css'
    plugins: ["themes", "json_data", 'ui', 'crrm', 'contextmenu']
  ).bind("loaded.jstree", (event, data) ->
    $(this).jstree("open_all")
  ).bind("select_node.jstree", (evt, data) ->
    window.location = '/admin/categories/' + data.rslt.obj.attr("id") + '/edit'
  ).bind("create.jstree", (evt, data) ->
    parent_id = data.inst._get_parent(data.rslt.obj).attr("id")
    title = data.rslt.obj[0].innerText.replace /^\s+/g, ""
    $.ajax '/admin/categories.json',
      type: 'POST'
      dataType: 'json'
      data:
        category:
          parent_id: parent_id
          title: title
      complete:(response) =>
        new_id = JSON.parse(response.responseText).id
        data.rslt.obj.attr("id", new_id)
  ).bind("rename_node.jstree", (evt, data) ->
    id = data.rslt.obj.attr("id")
    unless (typeof id == "undefined")
      title = data.rslt.obj[0].innerText.replace /^\s+/g, ""
      $.ajax "/admin/categories/#{id}.json",
        type: 'PUT'
        dataType: 'json'
        data:
          category:
            title: title
  ).bind("delete_node.jstree", (evt, data) ->
    id = data.rslt.obj.attr("id")
    $.ajax "/admin/categories/#{id}.json",
      type: 'DELETE'
  )

  $("#website_categories_jstree").jstree(
    json_data:
      ajax:
        url: "/admin/categories.json"
        data: (n) ->
          id: (if n.attr then n.attr("id") else '')
    plugins: ["themes", "json_data", 'ui']
  ).bind("loaded.jstree", (event, data) ->
    $(this).jstree("open_all")
  ).bind("select_node.jstree", (evt, data) ->
    window.location = '/categories/' + data.rslt.obj.attr("id")
  )