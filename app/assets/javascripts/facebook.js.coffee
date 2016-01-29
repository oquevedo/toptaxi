jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/es_ES/all.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  # FB.init(appId: '1480660865515919', cookie: true)

  $('.blog-share--facebook').on('click',(e) ->
    e.preventDefault()
    url = "#{$(this).attr('data-href')}"
    FB.ui
      method: 'share_open_graph',
      action_type: 'og.likes',
      action_properties: JSON.stringify({
          object: url,
      })
      href: url
    ,(response) ->
  )