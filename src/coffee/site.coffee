# Screenshot handler
$ ->
  $('.screenshot').on 'click', (e) ->
    $(this).toggleClass 'zoomed'
