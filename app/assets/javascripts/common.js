(function() {
  $(function() {
    var bg;

    $('.best_in_place').best_in_place();
    $('.nav a').each(function() {
      if ($(this).attr('href') === $(location).attr('pathname')) {
        return $(this).parent().addClass("active");
      }
    });
    Tipped.create('.tipped');
    bg = window.location.href.indexOf("/bg/") > -1;
    $("#admin_categories_jstree").jstree({
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
      contextmenu: {
        items: {
          create: {
            label: bg ? 'Създай' : 'Create'
          },
          rename: {
            label: bg ? 'Преименувай' : 'Rename'
          },
          remove: {
            label: bg ? 'Премахни' : 'Remove'
          },
          ccp: false
        }
      },
      themes: {
        url: '/assets/themes/default/style.css'
      },
      plugins: ["themes", "json_data", 'ui', 'crrm', 'contextmenu']
    }).bind("loaded.jstree", function(event, data) {
      return $(this).jstree("open_all");
    }).bind("select_node.jstree", function(evt, data) {
      return window.location = '/admin/categories/' + data.rslt.obj.attr("id") + '/edit';
    }).bind("create.jstree", function(evt, data) {
      var parent_id, title,
        _this = this;

      parent_id = data.inst._get_parent(data.rslt.obj).attr("id");
      title = data.rslt.obj[0].innerText.replace(/^\s+/g, "");
      return $.ajax('/admin/categories.json', {
        type: 'POST',
        dataType: 'json',
        data: {
          category: {
            parent_id: parent_id,
            title: title
          }
        },
        complete: function(response) {
          var new_id;

          new_id = JSON.parse(response.responseText).id;
          return data.rslt.obj.attr("id", new_id);
        }
      });
    }).bind("rename_node.jstree", function(evt, data) {
      var id, title;

      id = data.rslt.obj.attr("id");
      if (!(typeof id === "undefined")) {
        title = data.rslt.obj[0].innerText.replace(/^\s+/g, "");
        return $.ajax("/admin/categories/" + id + ".json", {
          type: 'PUT',
          dataType: 'json',
          data: {
            category: {
              title: title
            }
          }
        });
      }
    }).bind("delete_node.jstree", function(evt, data) {
      var id;

      id = data.rslt.obj.attr("id");
      return $.ajax("/admin/categories/" + id + ".json", {
        type: 'DELETE'
      });
    });
    $("#website_categories_jstree").jstree({
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
      themes: {
        url: '/assets/themes/default/style.css'
      },
      plugins: ["themes", "json_data", 'ui']
    }).bind("loaded.jstree", function(event, data) {
      return $(this).jstree("open_all");
    }).bind("select_node.jstree", function(evt, data) {
      return window.location = '/categories/' + data.rslt.obj.attr("id");
    });
    return $('#search').on('click', function() {
      var form;

      form = $(this).closest('form');
      $.ajax(form.attr('action') + '.js', {
        data: form.serialize(),
        complete: function(response) {
          return $('.content').html(response.responseText);
        }
      });
      $("#website_categories_jstree").jstree({
        json_data: {
          ajax: {
            url: "/admin/categories/for_articles.json",
            data: form.serialize()
          }
        },
        themes: {
          url: '/assets/themes/default/style.css'
        },
        plugins: ["themes", "json_data", 'ui']
      }).bind("loaded.jstree", function(event, data) {
        return $(this).jstree("open_all");
      }).bind("select_node.jstree", function(evt, data) {
        return window.location = '/categories/' + data.rslt.obj.attr("id");
      });
      return false;
    });
  });

}).call(this);
